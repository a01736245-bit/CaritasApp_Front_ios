import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

enum AppTab: Int, Hashable {
    case inicio = 0
    case servicios = 1
    case colaborar = 2
    case ayuda = 3
}

enum CollaborateSection {
    case voluntariado
    case donaciones
}

struct AppTabView: View {
    @Environment(SpeechService.self) private var speech: SpeechService?

    @State private var selectedTab: AppTab = .inicio
    @State private var collaborateSection: CollaborateSection = .voluntariado
    @State private var servicesPath: [ServicesRoute] = []
    @State private var collaboratePath: [CollaborateRoute] = []
    /// Pestaña y profundidad de la ruta de Servicios desde las que se abrió un recorrido
    /// (Donaciones o Ayuda). Solo existe mientras ese recorrido siga vigente.
    @State private var servicesReturn: ServicesReturn?
    /// Identifica la sesión vigente del orientador; al cambiar, el cuestionario empieza de cero.
    @State private var orientationSession = UUID()

    init() {
        #if canImport(UIKit)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.cariNavy)
        UITabBar.appearance().backgroundColor = UIColor(Color.cariBackground)
        #endif
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Inicio", systemImage: "house", value: AppTab.inicio) {
                NavigationStack {
                    HomeView(
                        onNecesitoAyuda: {
                            servicesPath = []
                            selectedTab = .servicios
                        },
                        onUnirmeAlEquipo: {
                            collaborateSection = .voluntariado
                            collaboratePath = []
                            selectedTab = .colaborar
                        },
                        onQuieroDonar: {
                            collaborateSection = .donaciones
                            collaboratePath = []
                            selectedTab = .colaborar
                        }
                    )
                }
                .withHiddenNavigationBar()
            }

            Tab("Servicios", systemImage: "square.grid.2x2", value: AppTab.servicios) {
                ServicesFlowView(
                    path: $servicesPath,
                    servicesReturn: $servicesReturn,
                    orientationSession: $orientationSession,
                    onExitToHome: { selectedTab = .inicio },
                    onReturn: { selectedTab = $0 }
                )
            }

            Tab("Colaborar", systemImage: "hands.sparkles", value: AppTab.colaborar) {
                CollaborateFlowView(
                    path: $collaboratePath,
                    section: $collaborateSection,
                    onExitToHome: { selectedTab = .inicio },
                    onConsultCenters: {
                        openServices(.centers(serviceId: nil, zone: nil), returningTo: .colaborar)
                    }
                )
            }

            Tab("Ayuda", systemImage: "questionmark.circle", value: AppTab.ayuda) {
                NavigationStack {
                    HelpView(
                        onGuideTap: { openServices(.guide, returningTo: .ayuda) },
                        onViewCentersTap: {
                            openServices(.centers(serviceId: nil, zone: nil), returningTo: .ayuda)
                        },
                        onBack: { selectedTab = .inicio }
                    )
                }
                .withHiddenNavigationBar()
            }
        }
        .tint(Color.cariRed)
        #if os(iOS)
        .toolbarBackground(Color.cariBackground, for: .tabBar)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
        #endif
        .onChange(of: selectedTab) { _, newTab in
            speech?.stop()
            // Al salir de Servicios, el regreso especial hacia otra pestaña deja de ser válido.
            if newTab != .servicios {
                servicesReturn = nil
            }
        }
        .onChange(of: servicesPath) { speech?.stop() }
        .onChange(of: collaboratePath) { speech?.stop() }
        .onChange(of: collaborateSection) { speech?.stop() }
    }

    /// Abre una ruta de Servicios sobre la ruta actual y recuerda la pestaña de origen,
    /// para que Atrás desde esa primera pantalla regrese a ella.
    private func openServices(_ route: ServicesRoute, returningTo origin: AppTab) {
        if route == .guide {
            if let existing = servicesPath.firstIndex(of: .guide) {
                servicesPath.removeSubrange(existing...)
            }
            orientationSession = UUID()
            servicesPath.append(route)
        } else if servicesPath.last != route {
            servicesPath.append(route)
        }
        servicesReturn = ServicesReturn(tab: origin, depth: servicesPath.count)
        selectedTab = .servicios
    }
}

extension View {
    @ViewBuilder
    func withHiddenNavigationBar() -> some View {
        #if os(iOS)
        self.toolbar(.hidden, for: .navigationBar)
        #else
        self
        #endif
    }
}

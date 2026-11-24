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
    @State private var selectedTab: AppTab = .inicio
    @State private var collaborateSection: CollaborateSection = .voluntariado
    @State private var servicesPath: [ServicesRoute] = []
    @State private var collaboratePath: [CollaborateRoute] = []
    /// Profundidad de la ruta de Servicios en la que se abrió el listado de centros desde
    /// una donación. Solo existe mientras ese recorrido siga vigente.
    @State private var donationCentersDepth: Int?

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
                    donationCentersDepth: $donationCentersDepth,
                    onExitToHome: { selectedTab = .inicio },
                    onReturnToDonations: { selectedTab = .colaborar }
                )
            }

            Tab("Colaborar", systemImage: "hands.sparkles", value: AppTab.colaborar) {
                CollaborateFlowView(
                    path: $collaboratePath,
                    section: $collaborateSection,
                    onExitToHome: { selectedTab = .inicio },
                    onConsultCenters: openCentersFromDonation
                )
            }

            Tab("Ayuda", systemImage: "questionmark.circle", value: AppTab.ayuda) {
                NavigationStack {
                    PlaceholderView(title: "Ayuda")
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
            // Al salir de Servicios, el regreso especial hacia Donaciones deja de ser válido.
            if newTab != .servicios {
                donationCentersDepth = nil
            }
        }
    }

    /// Abre el directorio general de centros sobre la ruta actual de Servicios y
    /// recuerda el origen para que Atrás vuelva al detalle de la donación.
    private func openCentersFromDonation() {
        let centersRoute = ServicesRoute.centers(serviceId: nil, zone: nil)
        if servicesPath.last != centersRoute {
            servicesPath.append(centersRoute)
        }
        donationCentersDepth = servicesPath.count
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

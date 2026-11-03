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
                            selectedTab = .servicios
                        },
                        onUnirmeAlEquipo: {
                            collaborateSection = .voluntariado
                            selectedTab = .colaborar
                        },
                        onQuieroDonar: {
                            collaborateSection = .donaciones
                            selectedTab = .colaborar
                        }
                    )
                }
                .withHiddenNavigationBar()
            }

            Tab("Servicios", systemImage: "square.grid.2x2", value: AppTab.servicios) {
                NavigationStack {
                    PlaceholderView(title: "Servicios")
                }
                .withHiddenNavigationBar()
            }

            Tab("Colaborar", systemImage: "hands.sparkles", value: AppTab.colaborar) {
                NavigationStack {
                    PlaceholderView(title: "Colaborar")
                }
                .withHiddenNavigationBar()
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
    }
}

private extension View {
    @ViewBuilder
    func withHiddenNavigationBar() -> some View {
        #if os(iOS)
        self.toolbar(.hidden, for: .navigationBar)
        #else
        self
        #endif
    }
}

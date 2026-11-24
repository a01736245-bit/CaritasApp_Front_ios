import SwiftUI

/// Pila de navegación de la pestaña Colaborar. La ruta y la sección viven en
/// `AppTabView` para conservarse al cambiar de pestaña.
struct CollaborateFlowView: View {
    @Binding var path: [CollaborateRoute]
    @Binding var section: CollaborateSection
    let onExitToHome: () -> Void
    let onConsultCenters: () -> Void

    var body: some View {
        NavigationStack(path: $path) {
            CollaborateView(
                section: $section,
                onDonationItemTap: { path.append(.donationDetail(id: $0)) },
                onBack: onExitToHome
            )
            .withHiddenNavigationBar()
            .navigationDestination(for: CollaborateRoute.self) { route in
                destination(for: route)
                    .withHiddenNavigationBar()
            }
        }
    }

    @ViewBuilder
    private func destination(for route: CollaborateRoute) -> some View {
        switch route {
        case .donationDetail(let id):
            if let item = DonationCatalog.findById(id) {
                DonationItemDetailView(
                    item: item,
                    onConsultCenters: onConsultCenters,
                    onBack: goBack
                )
            } else {
                PlaceholderView(title: "Artículo", onBack: goBack)
            }
        }
    }

    private func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}

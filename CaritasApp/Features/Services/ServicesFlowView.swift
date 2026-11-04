import SwiftUI

/// Pila de navegación de la pestaña Servicios. La ruta vive en `AppTabView`
/// para conservarse al cambiar de pestaña.
struct ServicesFlowView: View {
    @Binding var path: [ServicesRoute]
    let onExitToHome: () -> Void

    var body: some View {
        NavigationStack(path: $path) {
            ServicesView(
                onCategoryTap: { path.append(.category(id: $0)) },
                onGuideTap: { path.append(.guide) },
                onBack: onExitToHome
            )
            .withHiddenNavigationBar()
            .navigationDestination(for: ServicesRoute.self) { route in
                destination(for: route)
                    .withHiddenNavigationBar()
            }
        }
    }

    @ViewBuilder
    private func destination(for route: ServicesRoute) -> some View {
        switch route {
        case .category(let id):
            if let category = ServiceCatalog.findCategory(id) {
                CategoryView(
                    category: category,
                    onServiceTap: { path.append(.service(id: $0)) },
                    onBack: goBack
                )
            } else {
                PlaceholderView(title: "Categoría", onBack: goBack)
            }
        case .service(let id):
            if let service = ServiceCatalog.findService(id) {
                ServiceDetailView(
                    service: service,
                    onVerLugares: { path.append(.locationChoice(serviceId: service.id)) },
                    onBack: goBack
                )
            } else {
                PlaceholderView(title: "Servicio", onBack: goBack)
            }
        case .guide:
            OrientationFlowView(
                onExit: goBack,
                onOpenCategory: { path.append(.category(id: $0)) }
            )
        case .locationChoice:
            PlaceholderView(title: "Lugares", onBack: goBack)
        }
    }

    private func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}

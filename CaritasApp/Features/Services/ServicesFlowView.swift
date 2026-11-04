import SwiftUI

/// Pila de navegación de la pestaña Servicios. La ruta vive en `AppTabView`
/// para conservarse al cambiar de pestaña.
struct ServicesFlowView: View {
    @Binding var path: [ServicesRoute]
    let onExitToHome: () -> Void

    private let centerRepository = CenterRepository.shared

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
        case .locationChoice(let serviceId):
            LocationChoiceView(
                onShowAllCenters: { path.append(.centers(serviceId: serviceId, zone: nil)) },
                onChooseZone: { path.append(.zoneSelection(serviceId: serviceId)) },
                onBack: goBack
            )
        case .zoneSelection(let serviceId):
            ZoneSelectionView(
                zones: centerRepository.zones(),
                loadFailed: centerRepository.didFailToLoad,
                onZoneSelected: { path.append(.centers(serviceId: serviceId, zone: $0)) },
                onBack: goBack
            )
        case .centers(let serviceId, let zone):
            CentersView(
                centers: centerRepository.findByFilter(serviceId: serviceId, zone: zone),
                highlightServiceId: serviceId,
                loadFailed: centerRepository.didFailToLoad,
                onCenterTap: { path.append(.centerDetail(id: $0)) },
                onShowMap: { path.append(.map(serviceId: serviceId, zone: zone)) },
                onChooseOtherZone: { path.append(.zoneSelection(serviceId: serviceId)) },
                onBack: goBack
            )
        case .centerDetail(let id):
            if let center = centerRepository.findById(id) {
                CenterDetailView(center: center, onBack: goBack)
            } else {
                PlaceholderView(title: "Centro", onBack: goBack)
            }
        case .map(let serviceId, let zone):
            MapPlaceholderView(
                centers: centerRepository.findByFilter(serviceId: serviceId, zone: zone),
                loadFailed: centerRepository.didFailToLoad,
                onBackToList: goBack,
                onBack: goBack
            )
        }
    }

    private func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}

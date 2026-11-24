import SwiftUI

/// Origen temporal de un recorrido de Servicios abierto desde otra pestaña (Donaciones
/// o Ayuda): la pestaña a la que se regresa y la profundidad de la ruta en la que empezó.
struct ServicesReturn: Equatable {
    let tab: AppTab
    let depth: Int
}

/// Pila de navegación de la pestaña Servicios. La ruta vive en `AppTabView`
/// para conservarse al cambiar de pestaña.
struct ServicesFlowView: View {
    @Binding var path: [ServicesRoute]
    /// Es nil cuando el recorrido actual no proviene de otra pestaña.
    @Binding var servicesReturn: ServicesReturn?
    @Binding var orientationSession: UUID
    let onExitToHome: () -> Void
    let onReturn: (AppTab) -> Void

    private let centerRepository = CenterRepository.shared

    /// Servicios con al menos un centro asociado; se calcula una sola vez.
    private static let availableServiceIds: Set<String> = Set(
        ServiceCatalog.categories
            .flatMap(\.services)
            .map(\.id)
            .filter { !CenterRepository.shared.findByFilter(serviceId: $0).isEmpty }
    )

    var body: some View {
        NavigationStack(path: $path) {
            ServicesView(
                onCategoryTap: { path.append(.category(id: $0)) },
                onGuideTap: {
                    orientationSession = UUID()
                    path.append(.guide)
                },
                onBack: onExitToHome
            )
            .withHiddenNavigationBar()
            .navigationDestination(for: ServicesRoute.self) { route in
                destination(for: route)
                    .withHiddenNavigationBar()
            }
        }
        .onChange(of: path.count) { _, newCount in
            // Si la ruta se reduce sin pasar por `goBack` (por ejemplo, al tocar la pestaña
            // activa), el recorrido de origen ya no es válido y solo se descarta el marcador.
            guard let origin = servicesReturn, newCount < origin.depth else { return }
            servicesReturn = nil
        }
    }

    @ViewBuilder
    private func destination(for route: ServicesRoute) -> some View {
        switch route {
        case .category(let id):
            if let category = ServiceCatalog.findCategory(id) {
                CategoryView(
                    category: ServiceCategory(
                        id: category.id,
                        title: category.title,
                        systemImage: category.systemImage,
                        services: category.services.filter { Self.availableServiceIds.contains($0.id) }
                    ),
                    onServiceTap: { path.append(.service(id: $0)) },
                    onBack: goBack
                )
            } else {
                PlaceholderView(title: "Categoría", onBack: goBack)
            }
        case .service(let id):
            if let service = ServiceCatalog.findService(id), Self.availableServiceIds.contains(id) {
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
            .id(orientationSession)
        case .locationChoice(let serviceId):
            LocationChoiceView(
                onShowAllCenters: { path.append(.centers(serviceId: serviceId, zone: nil)) },
                onChooseZone: { path.append(.zoneSelection(serviceId: serviceId)) },
                onBack: goBack
            )
        case .zoneSelection(let serviceId):
            ZoneSelectionView(
                zones: centerRepository.availableZones(serviceId: serviceId),
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
        guard !path.isEmpty else { return }
        // Atrás desde la primera pantalla de un recorrido abierto desde otra pestaña regresa a ella.
        let origin = servicesReturn.flatMap { path.count == $0.depth ? $0.tab : nil }
        path.removeLast()
        if let origin {
            servicesReturn = nil
            onReturn(origin)
        }
    }
}

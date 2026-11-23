import SwiftUI

/// Pila de navegación de la pestaña Colaborar. La ruta y la sección viven en
/// `AppTabView` para conservarse al cambiar de pestaña.
struct CollaborateFlowView: View {
    @Binding var path: [CollaborateRoute]
    @Binding var section: CollaborateSection
    let onExitToHome: () -> Void

    var body: some View {
        NavigationStack(path: $path) {
            CollaborateView(
                section: $section,
                onOpportunityInfo: { path.append(.volunteerDetail(id: $0)) },
                onOpportunityApply: { path.append(.volunteerApplication) },
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
        case .volunteerDetail(let id):
            if let opportunity = VolunteerCatalog.findById(id) {
                VolunteerOpportunityDetailView(
                    opportunity: opportunity,
                    onParticipate: { path.append(.volunteerApplication) },
                    onBack: goBack
                )
            } else {
                PlaceholderView(title: "Oportunidad", onBack: goBack)
            }
        case .volunteerApplication:
            VolunteerApplicationInfoView(onBack: goBack)
        }
    }

    private func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}

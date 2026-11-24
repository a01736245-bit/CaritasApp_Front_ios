import SwiftUI

/// Raíz de Colaborar. Los chips cambian el contenido sin añadir pantallas a la pila;
/// la sección elegida vive en `AppTabView` para conservarse al cambiar de pestaña.
struct CollaborateView: View {
    @Binding var section: CollaborateSection
    let onOpportunityInfo: (String) -> Void
    let onOpportunityApply: () -> Void
    let onDonationItemTap: (String) -> Void
    let onBack: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            CariTopBar(onBack: onBack)

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 8) {
                        SectionChip(
                            title: "Voluntariado",
                            systemImage: "person.2",
                            isSelected: section == .voluntariado,
                            action: { section = .voluntariado }
                        )
                        SectionChip(
                            title: "Donar productos",
                            systemImage: "shippingbox",
                            isSelected: section == .donaciones,
                            action: { section = .donaciones }
                        )
                    }
                    .padding(4)
                    .padding(.top, 12)
                    .padding(.bottom, 18)

                    switch section {
                    case .voluntariado:
                        volunteerContent
                    case .donaciones:
                        DonationsView(onItemTap: onDonationItemTap)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .background(Color.cariBackground)
    }

    private var volunteerContent: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Forma parte del equipo")
                .font(CariTypography.headlineLarge)
                .foregroundStyle(Color.cariNavy)

            Text("Tu tiempo y experiencia pueden ayudar a otras personas.")
                .font(CariTypography.bodyLarge)
                .foregroundStyle(Color.cariNavy)
                .padding(.top, 8)
                .padding(.bottom, 18)

            VStack(spacing: 16) {
                ForEach(VolunteerCatalog.opportunities) { opportunity in
                    VolunteerOpportunityCard(
                        opportunity: opportunity,
                        onViewInfo: { onOpportunityInfo(opportunity.id) },
                        onParticipate: onOpportunityApply
                    )
                }
            }

            Text("Contenido de ejemplo. Cáritas puede actualizar las oportunidades.")
                .font(CariTypography.bodyMedium)
                .foregroundStyle(Color.cariNavyMuted)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.top, 16)
        }
    }

}

private struct SectionChip: View {
    let title: String
    let systemImage: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .accessibilityHidden(true)
                Text(title)
                    .font(CariTypography.bodyMedium)
            }
            .foregroundStyle(isSelected ? Color.cariRed : Color.cariNavyMuted)
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(isSelected ? Color.cariBackground : Color.clear)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .strokeBorder(isSelected ? Color.cariBorder : Color.clear, lineWidth: 1)
            )
            .contentShape(Capsule())
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

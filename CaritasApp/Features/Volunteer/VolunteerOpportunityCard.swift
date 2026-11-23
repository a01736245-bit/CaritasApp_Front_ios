import SwiftUI

/// Tarjeta de una oportunidad en el listado, con las acciones de ver información
/// y participar. Los dos botones comparten el ancho y su texto puede ocupar dos líneas.
struct VolunteerOpportunityCard: View {
    let opportunity: VolunteerOpportunity
    let onViewInfo: () -> Void
    let onParticipate: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: opportunity.systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26, height: 26)
                    .foregroundStyle(Color.cariRed)
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: 0) {
                    Text(opportunity.title)
                        .font(CariTypography.titleMedium)
                        .foregroundStyle(Color.cariNavy)
                    Text(opportunity.shortDescription)
                        .font(CariTypography.bodyMedium)
                        .foregroundStyle(Color.cariNavyMuted)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            if let location = opportunity.location {
                infoLine(systemImage: "mappin", text: location)
            }
            if let schedule = opportunity.schedule {
                infoLine(systemImage: "clock", text: schedule)
            }

            HStack(spacing: 12) {
                SecondaryButton(title: "Ver información", action: onViewInfo)
                PrimaryButton(title: "Quiero participar", action: onParticipate)
            }
            .padding(.top, 14)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.cariBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.cariBorder, lineWidth: 1)
        )
    }

    private func infoLine(systemImage: String, text: String) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Image(systemName: systemImage)
                .frame(width: 18)
                .foregroundStyle(Color.cariNavyMuted)
                .accessibilityHidden(true)
            Text(text)
                .font(CariTypography.bodyMedium)
                .foregroundStyle(Color.cariNavyMuted)
        }
        .padding(.top, 6)
    }
}

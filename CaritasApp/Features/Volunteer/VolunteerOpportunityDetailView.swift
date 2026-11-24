import SwiftUI

struct VolunteerOpportunityDetailView: View {
    let opportunity: VolunteerOpportunity
    let onParticipate: () -> Void
    let onBack: () -> Void

    private let activityCheckColor = Color(red: 0x2E / 255, green: 0x7D / 255, blue: 0x32 / 255)

    private var speakableText: String {
        joinSpeakable(
            opportunity.title,
            opportunity.shortDescription,
            opportunity.activities.isEmpty
                ? nil
                : "¿Qué actividades se realizan? "
                    + opportunity.activities.map { "\($0)." }.joined(separator: " "),
            opportunity.whoCanParticipate.map { "¿Quién puede participar? \($0)" },
            opportunity.schedule.map { "Horario: \($0)" },
            opportunity.location.map { "Ubicación: \($0)" },
            opportunity.requirements.isEmpty
                ? nil
                : "Requisitos: " + opportunity.requirements.joined(separator: ", "),
            opportunity.contact.map { "Contacto: \($0)" },
            opportunity.hasDetail ? nil : pendingSpeakableText
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            CariTopBar(title: opportunity.title, onBack: onBack, speakableText: speakableText)

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text(opportunity.title)
                        .font(CariTypography.headlineLarge)
                        .foregroundStyle(Color.cariNavy)
                        .padding(.top, 20)
                        .padding(.bottom, 4)

                    Text(opportunity.shortDescription)
                        .font(CariTypography.bodyLarge)
                        .foregroundStyle(Color.cariNavy)
                        .padding(.bottom, 18)

                    detailCard

                    PrimaryButton(title: "Quiero participar", action: onParticipate)
                        .padding(.top, 28)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .background(Color.cariBackground)
    }

    /// Solo se muestran las secciones que tienen contenido. Si no hay ninguna
    /// información de detalle, aparece el aviso de información pendiente.
    private var detailCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            if !opportunity.activities.isEmpty {
                Text("¿Qué actividades se realizan?")
                    .font(CariTypography.titleMedium)
                    .foregroundStyle(Color.cariNavy)
                    .padding(.bottom, 8)

                VStack(alignment: .leading, spacing: 6) {
                    ForEach(opportunity.activities, id: \.self) { activity in
                        HStack(spacing: 8) {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .foregroundStyle(activityCheckColor)
                                .accessibilityHidden(true)
                            Text(activity)
                                .font(CariTypography.bodyMedium)
                                .foregroundStyle(Color.cariNavyMuted)
                        }
                    }
                }
            }

            if let whoCanParticipate = opportunity.whoCanParticipate {
                Text("¿Quién puede participar?")
                    .font(CariTypography.titleMedium)
                    .foregroundStyle(Color.cariNavy)
                    .padding(.top, 16)
                    .padding(.bottom, 4)
                Text(whoCanParticipate)
                    .font(CariTypography.bodyMedium)
                    .foregroundStyle(Color.cariNavyMuted)
            }

            if let schedule = opportunity.schedule {
                labeledRow(label: "Horario", systemImage: "clock", text: schedule)
            }
            if let location = opportunity.location {
                labeledRow(label: "Ubicación", systemImage: "mappin", text: location)
            }

            if !opportunity.requirements.isEmpty {
                Text("Requisitos")
                    .font(CariTypography.titleMedium)
                    .foregroundStyle(Color.cariNavy)
                    .padding(.top, 16)
                    .padding(.bottom, 4)
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(opportunity.requirements, id: \.self) { requirement in
                        Text("• \(requirement)")
                            .font(CariTypography.bodyMedium)
                            .foregroundStyle(Color.cariNavyMuted)
                    }
                }
            }

            if let contact = opportunity.contact {
                labeledRow(label: "Contacto", systemImage: "phone", text: contact)
            }

            if !opportunity.hasDetail {
                Text("Información pendiente de confirmar.")
                    .font(CariTypography.bodyMedium)
                    .foregroundStyle(Color.cariNavyMuted)
                    .padding(.top, 8)
            }
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

    private func labeledRow(label: String, systemImage: String, text: String) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label)
                .font(CariTypography.titleMedium)
                .foregroundStyle(Color.cariNavy)
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Image(systemName: systemImage)
                    .frame(width: 18)
                    .foregroundStyle(Color.cariNavyMuted)
                    .accessibilityHidden(true)
                Text(text)
                    .font(CariTypography.bodyMedium)
                    .foregroundStyle(Color.cariNavyMuted)
            }
            .padding(.top, 4)
        }
        .padding(.top, 16)
    }
}

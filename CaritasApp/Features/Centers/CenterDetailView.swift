import SwiftUI

/// Detalle de un centro. Solo muestra los datos que el centro tiene registrados:
/// las secciones vacías no aparecen.
struct CenterDetailView: View {
    let center: Center
    let onBack: () -> Void

    @Environment(\.openURL) private var openURL
    @State private var alertMessage: String?

    private static let phoneErrorMessage = "No fue posible abrir la aplicación Teléfono en este dispositivo."
    private static let linkErrorMessage = "No fue posible abrir el enlace en este dispositivo."

    private var zoneLine: String {
        [center.zone.map(formatZoneLabel), center.deanery]
            .compactMap { $0 }
            .joined(separator: " · ")
    }

    private var speakableText: String {
        centerDetailSpeakableText(center)
    }

    var body: some View {
        VStack(spacing: 0) {
            CariTopBar(title: center.name, onBack: onBack, speakableText: speakableText)

            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    Text(center.name)
                        .font(CariTypography.headlineLarge)
                        .foregroundStyle(Color.cariNavy)
                        .padding(.top, 20)
                        .padding(.bottom, 4)

                    if !zoneLine.isEmpty {
                        DetailCard(title: "Zona") {
                            Text(zoneLine)
                                .font(CariTypography.bodyMedium)
                                .foregroundStyle(Color.cariNavyMuted)
                        }
                    }

                    DetailCard(title: "Dirección") {
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "mappin.and.ellipse")
                                .frame(width: 20)
                                .foregroundStyle(Color.cariRed)
                                .accessibilityHidden(true)
                            Text(center.address)
                                .font(CariTypography.bodyMedium)
                                .foregroundStyle(Color.cariNavyMuted)
                        }
                    }

                    if !center.phones.isEmpty {
                        DetailCard(title: "Teléfono") {
                            VStack(alignment: .leading, spacing: 0) {
                                ForEach(center.phones, id: \.self) { phone in
                                    phoneRow(phone)
                                }
                            }
                        }
                    }

                    if !center.parishResponsibles.isEmpty {
                        DetailCard(title: "Responsables de la parroquia") {
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(center.parishResponsibles, id: \.role) { item in
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text(item.role)
                                            .font(CariTypography.labelLarge)
                                            .foregroundStyle(Color.cariNavy)
                                        Text(item.name)
                                            .font(CariTypography.bodyMedium)
                                            .foregroundStyle(Color.cariNavyMuted)
                                    }
                                    .accessibilityElement(children: .combine)
                                }
                            }
                        }
                    }

                    if !center.services.isEmpty {
                        DetailCard(title: "Servicios") {
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(center.services, id: \.self) { key in
                                    HStack(alignment: .top, spacing: 8) {
                                        Text("•")
                                            .font(CariTypography.bodyMedium)
                                            .foregroundStyle(Color.cariRed)
                                            .accessibilityHidden(true)
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(displayServiceLabel(ExcelServiceCatalog.labelFor(key)))
                                                .font(CariTypography.bodyMedium)
                                                .foregroundStyle(Color.cariNavyMuted)
                                            Text(scheduleText(for: key))
                                                .font(CariTypography.bodyMedium)
                                                .foregroundStyle(Color.cariNavy)
                                        }
                                    }
                                    .accessibilityElement(children: .combine)
                                }
                            }
                        }
                    }

                    if center.offersOtherBenefits {
                        DetailCard(title: "Otros beneficios") {
                            VStack(alignment: .leading, spacing: 8) {
                                if let details = center.otherBenefitsDetails,
                                   !details.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                    Text(details)
                                        .font(CariTypography.bodyMedium)
                                        .foregroundStyle(Color.cariNavyMuted)
                                }
                                Text(otherBenefitsNotice)
                                    .font(CariTypography.bodyMedium)
                                    .foregroundStyle(Color.cariNavy)
                            }
                        }
                    }

                    if let mapsURL = center.mapsURL {
                        PrimaryButton(
                            title: "Cómo llegar",
                            action: { open(mapsURL, errorMessage: Self.linkErrorMessage) },
                            systemImage: "mappin.circle.fill"
                        )
                        .padding(.top, 4)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .background(Color.cariBackground)
        .alert(
            alertMessage ?? "",
            isPresented: Binding(
                get: { alertMessage != nil },
                set: { if !$0 { alertMessage = nil } }
            )
        ) {
            Button("Aceptar", role: .cancel) {}
        }
    }

    private func scheduleText(for key: String) -> String {
        if let schedule = center.schedule(forServiceKey: key) {
            return "Días y horarios: \(schedule)"
        }
        return "Llama a esta parroquia para consultar días y horarios."
    }

    /// Pide al sistema abrir el enlace; si no puede, muestra el aviso indicado.
    private func open(_ url: URL, errorMessage: String) {
        openURL(url) { accepted in
            if !accepted {
                alertMessage = errorMessage
            }
        }
    }

    /// Abre el sistema de llamadas con el número; el usuario confirma la llamada.
    @ViewBuilder
    private func phoneRow(_ phone: String) -> some View {
        let label = HStack(spacing: 8) {
            Image(systemName: "phone")
                .frame(width: 20)
                .foregroundStyle(Color.cariRed)
                .accessibilityHidden(true)
            Text(phone)
                .font(CariTypography.bodyMedium)
                .bold()
                .foregroundStyle(Color.cariNavy)
        }
        .frame(maxWidth: .infinity, minHeight: 44, alignment: .leading)
        .contentShape(Rectangle())

        if let url = phoneDialURL(phone) {
            Button {
                open(url, errorMessage: Self.phoneErrorMessage)
            } label: {
                label
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Llamar al \(phone)")
        } else {
            label
        }
    }
}

private struct DetailCard<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(CariTypography.titleMedium)
                .foregroundStyle(Color.cariNavy)
            content
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.cariBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.cariBorder, lineWidth: 1)
        )
    }
}

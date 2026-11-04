import SwiftUI

/// Detalle de un centro. Solo muestra los datos que el centro tiene registrados:
/// las secciones vacías no aparecen.
struct CenterDetailView: View {
    let center: Center
    let onBack: () -> Void

    @Environment(\.openURL) private var openURL

    private var zoneLine: String {
        [center.zone.map(formatZoneLabel), center.deanery]
            .compactMap { $0 }
            .joined(separator: " · ")
    }

    var body: some View {
        VStack(spacing: 0) {
            CariTopBar(title: center.name, onBack: onBack)

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

                    if !center.services.isEmpty {
                        DetailCard(title: "Servicios") {
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(center.services, id: \.self) { key in
                                    HStack(alignment: .top, spacing: 8) {
                                        Text("•")
                                            .foregroundStyle(Color.cariRed)
                                        Text(displayServiceLabel(ExcelServiceCatalog.labelFor(key)))
                                            .foregroundStyle(Color.cariNavyMuted)
                                    }
                                    .font(CariTypography.bodyMedium)
                                }
                            }
                        }
                    }

                    if let mapsURL = center.mapsURL {
                        PrimaryButton(
                            title: "Cómo llegar",
                            action: { openURL(mapsURL) },
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

        if let url = phoneURL(phone) {
            Button {
                openURL(url)
            } label: {
                label
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Llamar al \(phone)")
        } else {
            label
        }
    }

    private func phoneURL(_ phone: String) -> URL? {
        let dialable = phone.filter { $0.isNumber || $0 == "+" }
        return dialable.isEmpty ? nil : URL(string: "tel:\(dialable)")
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

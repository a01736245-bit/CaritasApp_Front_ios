import SwiftUI

/// Tarjeta de un centro en el listado. Muestra solo datos que existen:
/// el teléfono aparece si hay al menos uno y se muestra únicamente el primero.
struct CenterCard: View {
    let center: Center
    let highlightServiceId: String?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "mappin.and.ellipse")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 26, height: 26)
                        .foregroundStyle(Color.cariRed)
                        .accessibilityHidden(true)

                    VStack(alignment: .leading, spacing: 0) {
                        Text(center.name)
                            .font(CariTypography.titleMedium)
                            .foregroundStyle(Color.cariNavy)
                        serviceSummary
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                infoRow(systemImage: "location", text: center.address)
                    .padding(.top, 16)

                if let phone = center.phones.first {
                    infoRow(systemImage: "phone", text: phone)
                        .padding(.top, 6)
                }

                HStack(spacing: 0) {
                    Spacer()
                    Text("Ver detalles")
                        .font(CariTypography.bodyMedium)
                        .foregroundStyle(Color.cariRed)
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color.cariRed)
                        .accessibilityHidden(true)
                }
                .padding(.top, 10)
            }
            .padding(18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.cariBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color.cariBorder, lineWidth: 1)
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    private func infoRow(systemImage: String, text: String) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Image(systemName: systemImage)
                .frame(width: 18)
                .foregroundStyle(Color.cariNavyMuted)
                .accessibilityHidden(true)
            Text(text)
                .font(CariTypography.bodyMedium)
                .foregroundStyle(Color.cariNavyMuted)
        }
    }

    /// Con un servicio de origen presente en el centro, destaca solo ese servicio.
    /// Sin servicio de origen, muestra hasta dos servicios y cuántos faltan.
    @ViewBuilder
    private var serviceSummary: some View {
        if !center.services.isEmpty {
            if let key = highlightedServiceKey {
                Text(displayServiceLabel(ExcelServiceCatalog.labelFor(key)))
                    .font(CariTypography.bodyMedium)
                    .bold()
                    .foregroundStyle(Color.cariNavy)
                if center.services.count > 1 {
                    Text("También ofrece otros servicios.")
                        .font(CariTypography.bodyMedium)
                        .foregroundStyle(Color.cariNavyMuted)
                }
            } else {
                Text(generalServiceSummary)
                    .font(CariTypography.bodyMedium)
                    .foregroundStyle(Color.cariNavyMuted)
            }
        }
    }

    private var highlightedServiceKey: String? {
        highlightServiceId
            .map { ServiceExcelMapping.excelKeys(for: $0) }?
            .first { center.services.contains($0) }
    }

    private var generalServiceSummary: String {
        let shown = center.services.prefix(2).map { displayServiceLabel(ExcelServiceCatalog.labelFor($0)) }
        let remaining = center.services.count - shown.count
        let text = shown.joined(separator: ", ")
        switch remaining {
        case 0: return text
        case 1: return text + " y 1 servicio más."
        default: return text + " y \(remaining) servicios más."
        }
    }
}

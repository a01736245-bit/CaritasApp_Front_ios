import SwiftUI

struct ZoneSelectionView: View {
    let zones: [String]
    let loadFailed: Bool
    let onZoneSelected: (String) -> Void
    let onBack: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            CariTopBar(onBack: onBack)

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Elige tu zona")
                        .font(CariTypography.headlineLarge)
                        .foregroundStyle(Color.cariNavy)
                        .padding(.top, 20)
                        .padding(.bottom, 8)

                    Text("Selecciona la zona más cercana a ti para ver los centros disponibles.")
                        .font(CariTypography.bodyLarge)
                        .foregroundStyle(Color.cariNavy)
                        .padding(.bottom, 18)

                    if loadFailed {
                        CentersLoadErrorState()
                    } else {
                        VStack(spacing: 14) {
                            ForEach(zones, id: \.self) { zone in
                                ZoneRow(zone: zone, action: { onZoneSelected(zone) })
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .background(Color.cariBackground)
    }
}

private struct ZoneRow: View {
    let zone: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 0) {
                Image(systemName: "mappin.and.ellipse")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.cariRed)
                    .accessibilityHidden(true)

                Text(formatZoneLabel(zone))
                    .font(CariTypography.titleMedium)
                    .foregroundStyle(Color.cariNavy)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 14)

                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.cariNavy)
                    .accessibilityHidden(true)
            }
            .padding(18)
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
}

import SwiftUI

/// Mapa provisional: es una ilustración, no un mapa real. Los pines siguen un
/// patrón fijo y no representan ubicaciones geográficas.
struct MapPlaceholderView: View {
    let centers: [Center]
    let loadFailed: Bool
    let onBackToList: () -> Void
    let onBack: () -> Void

    @State private var selectedIndex = 0
    @Environment(\.openURL) private var openURL

    private var selectedCenter: Center? {
        guard !centers.isEmpty else { return nil }
        return centers.indices.contains(selectedIndex) ? centers[selectedIndex] : centers[0]
    }

    var body: some View {
        VStack(spacing: 0) {
            CariTopBar(title: "Mapa de centros", onBack: onBack)

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SecondaryButton(title: "Regresar a la lista", action: onBackToList)
                        .padding(.top, 16)
                        .padding(.bottom, 14)

                    if let selectedCenter {
                        mapContent(selectedCenter: selectedCenter)
                    } else {
                        emptyState
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .background(Color.cariBackground)
    }

    private func mapContent(selectedCenter: Center) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            MapPinArea(
                total: centers.count,
                selectedIndex: min(max(selectedIndex, 0), centers.count - 1)
            )

            Text("El mapa es una ayuda para orientarte.")
                .font(CariTypography.bodyMedium)
                .foregroundStyle(Color.cariNavyMuted)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.top, 10)
                .padding(.bottom, 16)

            VStack(alignment: .leading, spacing: 0) {
                Text(selectedCenter.name)
                    .font(CariTypography.titleMedium)
                    .foregroundStyle(Color.cariNavy)

                Text(selectedCenter.address)
                    .font(CariTypography.bodyMedium)
                    .foregroundStyle(Color.cariNavyMuted)
                    .padding(.top, 4)
                    .padding(.bottom, 14)

                if let mapsURL = selectedCenter.mapsURL {
                    PrimaryButton(
                        title: "Cómo llegar",
                        action: { openURL(mapsURL) },
                        systemImage: "mappin.circle.fill"
                    )
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

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(Array(centers.enumerated()), id: \.element.id) { index, center in
                        CenterChip(
                            text: center.name,
                            isSelected: index == selectedIndex,
                            action: { selectedIndex = index }
                        )
                    }
                }
                .padding(.vertical, 2)
            }
            .padding(.top, 16)
        }
    }

    @ViewBuilder
    private var emptyState: some View {
        if loadFailed {
            CentersLoadErrorState()
        } else {
            VStack(spacing: 12) {
                Image(systemName: "wrench.and.screwdriver")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Color.cariNavyMuted)
                    .accessibilityHidden(true)

                Text("No hay centros para mostrar en el mapa todavía.")
                    .font(CariTypography.bodyLarge)
                    .foregroundStyle(Color.cariNavyMuted)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 10)
        }
    }
}

/// Área ilustrativa con un pin por centro, en posiciones fijas que se repiten.
private struct MapPinArea: View {
    let total: Int
    let selectedIndex: Int

    private let positions: [(x: Double, y: Double)] = [
        (-0.6, -0.5), (0.5, -0.6), (-0.2, 0.1),
        (0.6, 0.4), (-0.7, 0.6), (0.1, -0.2)
    ]

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<total, id: \.self) { index in
                let isSelected = index == selectedIndex
                let size: CGFloat = isSelected ? 30 : 24
                let position = positions[index % positions.count]

                Image(systemName: "mappin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .foregroundStyle(isSelected ? Color.cariRed : Color.cariNavy)
                    .position(
                        x: geometry.size.width / 2 + position.x * (geometry.size.width - size) / 2,
                        y: geometry.size.height / 2 + position.y * (geometry.size.height - size) / 2
                    )
            }
        }
        .frame(height: 220)
        .background(
            Color(red: 237 / 255, green: 240 / 255, blue: 244 / 255),
            in: RoundedRectangle(cornerRadius: 16)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.cariBorder, lineWidth: 1)
        )
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }
}

private struct CenterChip: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(CariTypography.bodyMedium)
                .foregroundStyle(isSelected ? Color.cariRed : Color.cariNavy)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color.cariBackground)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .strokeBorder(isSelected ? Color.cariRed : Color.cariBorder, lineWidth: 1.5)
                )
                .contentShape(Capsule())
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

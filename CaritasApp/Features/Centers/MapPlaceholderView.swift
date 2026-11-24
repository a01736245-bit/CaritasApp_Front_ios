import SwiftUI

/// Mapa ilustrativo: la imagen es de fondo y los pines se reparten en una cuadrícula.
/// No es un mapa real ni los pines representan ubicaciones geográficas.
struct MapPlaceholderView: View {
    let centers: [Center]
    let loadFailed: Bool
    let onBackToList: () -> Void
    let onBack: () -> Void

    @State private var selectedCenterId: String?
    @State private var showLinkError = false
    @Environment(\.openURL) private var openURL

    /// Centro seleccionado; si ya no está en la lista, el primero disponible.
    private var selectedCenter: Center? {
        centers.first { $0.id == selectedCenterId } ?? centers.first
    }

    private var speakableText: String {
        joinSpeakable(
            "Mapa de centros",
            "Mapa ilustrativo. Consulta la ubicación exacta en Cómo llegar.",
            loadFailed
                ? "No pudimos cargar los centros. Intenta de nuevo más tarde."
                : centersSpeakableSummary(centers)
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            CariTopBar(title: "Mapa de centros", onBack: onBack, speakableText: speakableText)

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
        .alert("No fue posible abrir el enlace en este dispositivo.", isPresented: $showLinkError) {
            Button("Aceptar", role: .cancel) {}
        }
    }

    private func mapContent(selectedCenter: Center) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            MapPinLayout(count: centers.count) {
                ForEach(centers) { center in
                    MapPinButton(
                        name: center.name,
                        isSelected: center.id == selectedCenter.id,
                        action: { selectedCenterId = center.id }
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .background {
                Image("mapa_centros")
                    .resizable()
                    .scaledToFill()
                    .accessibilityHidden(true)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color.cariBorder, lineWidth: 1)
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
                    .padding(.bottom, selectedCenter.mapsURL == nil ? 0 : 14)

                if let mapsURL = selectedCenter.mapsURL {
                    PrimaryButton(
                        title: "Cómo llegar",
                        action: {
                            openURL(mapsURL) { accepted in
                                if !accepted {
                                    showLinkError = true
                                }
                            }
                        },
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
                    ForEach(centers) { center in
                        CenterChip(
                            text: center.name,
                            isSelected: center.id == selectedCenter.id,
                            action: { selectedCenterId = center.id }
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

// MARK: - Cuadrícula de pines

/// Cálculo de la cuadrícula de pines: botones de 48 puntos con paso de 56, margen de 8
/// y altura mínima de 220.
enum MapPinGrid {
    static let pinSize: CGFloat = 48
    static let pitch: CGFloat = 56
    static let margin: CGFloat = 8
    static let minHeight: CGFloat = 220

    static func columns(width: CGFloat) -> Int {
        max(1, Int(width / pitch))
    }

    static func rows(count: Int, columns: Int) -> Int {
        max(1, (count + columns - 1) / columns)
    }

    static func height(rows: Int) -> CGFloat {
        max(minHeight, CGFloat(rows) * pitch + 16)
    }

    /// Centro del pin `index` dentro de un área de ancho `width`.
    static func center(index: Int, count: Int, width: CGFloat) -> CGPoint {
        let columns = columns(width: width)
        let rows = rows(count: count, columns: columns)
        let height = height(rows: rows)
        let column = index % columns
        let row = index / columns

        let horizontalBias = columns == 1 ? 0 : -1 + 2 * CGFloat(column) / CGFloat(columns - 1)
        let verticalBias = rows == 1 ? 0 : -1 + 2 * CGFloat(row) / CGFloat(rows - 1)

        let freeWidth = width - 2 * margin - pinSize
        let freeHeight = height - 2 * margin - pinSize
        return CGPoint(
            x: margin + freeWidth / 2 * (1 + horizontalBias) + pinSize / 2,
            y: margin + freeHeight / 2 * (1 + verticalBias) + pinSize / 2
        )
    }
}

private struct MapPinLayout: Layout {
    let count: Int

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? 320
        let columns = MapPinGrid.columns(width: width)
        return CGSize(width: width, height: MapPinGrid.height(rows: MapPinGrid.rows(count: count, columns: columns)))
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        for (index, subview) in subviews.enumerated() {
            let center = MapPinGrid.center(index: index, count: subviews.count, width: bounds.width)
            subview.place(
                at: CGPoint(x: bounds.minX + center.x, y: bounds.minY + center.y),
                anchor: .center,
                proposal: ProposedViewSize(width: MapPinGrid.pinSize, height: MapPinGrid.pinSize)
            )
        }
    }
}

private struct MapPinButton: View {
    let name: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "mappin")
                .resizable()
                .scaledToFit()
                .frame(width: isSelected ? 30 : 24, height: isSelected ? 30 : 24)
                .foregroundStyle(isSelected ? Color.cariRed : Color.cariNavy)
                .frame(width: MapPinGrid.pinSize, height: MapPinGrid.pinSize)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Seleccionar \(name)")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
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

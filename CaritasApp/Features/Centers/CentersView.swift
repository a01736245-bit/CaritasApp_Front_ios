import SwiftUI

/// Listado de centros. Recibe la lista ya filtrada: la pantalla solo la presenta.
struct CentersView: View {
    let centers: [Center]
    let highlightServiceId: String?
    let loadFailed: Bool
    let onCenterTap: (String) -> Void
    let onShowMap: () -> Void
    let onChooseOtherZone: () -> Void
    let onBack: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            CariTopBar(onBack: onBack)

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Centros de ayuda")
                        .font(CariTypography.headlineLarge)
                        .foregroundStyle(Color.cariNavy)
                        .padding(.top, 20)
                        .padding(.bottom, 8)

                    Text("Elige el lugar que mejor se adapte a tu necesidad. Después, si lo deseas, puedes consultar el mapa.")
                        .font(CariTypography.bodyLarge)
                        .foregroundStyle(Color.cariNavy)
                        .padding(.bottom, 18)

                    HStack(spacing: 12) {
                        SecondaryButton(title: "Ver mapa", action: onShowMap)
                        SecondaryButton(title: "Elegir otra zona", action: onChooseOtherZone)
                    }

                    content
                        .padding(.top, 18)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .background(Color.cariBackground)
    }

    @ViewBuilder
    private var content: some View {
        if loadFailed {
            CentersLoadErrorState()
        } else if centers.isEmpty {
            VStack(spacing: 12) {
                Image(systemName: "wrench.and.screwdriver")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Color.cariNavyMuted)
                    .accessibilityHidden(true)

                Text("No encontramos centros confirmados para esta búsqueda todavía.")
                    .font(CariTypography.bodyLarge)
                    .foregroundStyle(Color.cariNavyMuted)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 6)
        } else {
            VStack(spacing: 16) {
                ForEach(centers) { center in
                    CenterCard(
                        center: center,
                        highlightServiceId: highlightServiceId,
                        action: { onCenterTap(center.id) }
                    )
                }
            }
        }
    }
}

/// Aviso cuando no se pudieron cargar los datos de centros (distinto de "sin resultados").
struct CentersLoadErrorState: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundStyle(Color.cariNavyMuted)
                .accessibilityHidden(true)

            Text("No pudimos cargar los centros. Intenta de nuevo más tarde.")
                .font(CariTypography.bodyLarge)
                .foregroundStyle(Color.cariNavyMuted)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 6)
    }
}

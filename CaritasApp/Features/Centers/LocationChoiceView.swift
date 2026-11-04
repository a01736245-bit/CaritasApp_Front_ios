import SwiftUI

/// Pantalla previa al listado de centros. No usa la ubicación del dispositivo:
/// se puede abrir el listado sin filtrar por zona o elegir una zona.
struct LocationChoiceView: View {
    let onShowAllCenters: () -> Void
    let onChooseZone: () -> Void
    let onBack: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            CariTopBar(onBack: onBack)

            ScrollView {
                VStack(spacing: 0) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 18)
                            .strokeBorder(Color.cariRed, lineWidth: 1.5)
                            .frame(width: 64, height: 64)
                        Image(systemName: "mappin.and.ellipse")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(Color.cariRed)
                    }
                    .accessibilityHidden(true)

                    Text("¿Cómo quieres ver los lugares?")
                        .font(CariTypography.headlineLarge)
                        .foregroundStyle(Color.cariNavy)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)

                    Text("Puedes ver todos los centros disponibles o elegir tu zona para ver solo los de esa zona.")
                        .font(CariTypography.bodyLarge)
                        .foregroundStyle(Color.cariNavy)
                        .multilineTextAlignment(.center)
                        .padding(.top, 12)

                    PrimaryButton(title: "Ver todos los centros", action: onShowAllCenters)
                        .padding(.top, 28)

                    SecondaryButton(title: "Elegir mi zona", action: onChooseZone)
                        .padding(.top, 14)

                    Text("No necesitas compartir tu ubicación para consultar los centros.")
                        .font(CariTypography.bodyMedium)
                        .foregroundStyle(Color.cariNavyMuted)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 20)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 24)
            }
        }
        .background(Color.cariBackground)
    }
}

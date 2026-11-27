import SwiftUI

/// Pantalla previa al listado de centros de un servicio. No usa la ubicación del dispositivo:
/// se elige una zona o se abre el listado del servicio sin filtrar por zona.
struct LocationChoiceView: View {
    let onShowAllCenters: () -> Void
    let onChooseZone: () -> Void
    let onBack: () -> Void

    private static let title = "¿Cómo quieres buscar los centros?"
    private static let description = "Elige una zona o consulta todos los centros de este servicio."

    private var speakableText: String {
        joinSpeakable(
            Self.title,
            Self.description,
            "Elegir mi zona.",
            "Ver centros sin filtrar."
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            CariTopBar(onBack: onBack, speakableText: speakableText)

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

                    Text(Self.title)
                        .font(CariTypography.headlineLarge)
                        .foregroundStyle(Color.cariNavy)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)

                    Text(Self.description)
                        .font(CariTypography.bodyLarge)
                        .foregroundStyle(Color.cariNavy)
                        .multilineTextAlignment(.center)
                        .padding(.top, 12)

                    PrimaryButton(title: "Elegir mi zona", action: onChooseZone)
                        .padding(.top, 28)

                    SecondaryButton(title: "Ver centros sin filtrar", action: onShowAllCenters)
                        .padding(.top, 14)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 24)
            }
        }
        .background(Color.cariBackground)
    }
}

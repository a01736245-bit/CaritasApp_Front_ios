import SwiftUI

struct HomeView: View {
    let onNecesitoAyuda: () -> Void
    let onUnirmeAlEquipo: () -> Void
    let onQuieroDonar: () -> Void

    private var speakableText: String {
        joinSpeakable(
            "¿Qué deseas hacer?",
            "Elige la opción que mejor se acerque a lo que necesitas.",
            "Necesito ayuda. Encuentra los servicios que Cáritas ofrece.",
            "Unirme al equipo. Conoce cómo puedes participar.",
            "Quiero donar productos. Consulta qué necesita Cáritas actualmente."
        )
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                CariTopBar(speakableText: speakableText)

                VStack(alignment: .leading, spacing: 18) {
                    Text("¿Qué deseas hacer?")
                        .font(CariTypography.headlineLarge)
                        .foregroundStyle(Color.cariNavy)
                        .padding(.top, 22)

                    Text("Elige la opción que mejor se acerque a lo que necesitas.")
                        .font(CariTypography.bodyLarge)
                        .foregroundStyle(Color.cariNavy)

                    OptionCard(
                        systemImage: "questionmark.circle",
                        title: "Necesito ayuda",
                        description: "Encuentra los servicios que Cáritas ofrece.",
                        action: onNecesitoAyuda
                    )

                    OptionCard(
                        systemImage: "person.2",
                        title: "Unirme al equipo",
                        description: "Conoce cómo puedes participar.",
                        action: onUnirmeAlEquipo
                    )

                    OptionCard(
                        systemImage: "shippingbox",
                        title: "Quiero donar productos",
                        description: "Consulta qué necesita Cáritas actualmente.",
                        action: onQuieroDonar
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .background(Color.cariBackground)
    }
}

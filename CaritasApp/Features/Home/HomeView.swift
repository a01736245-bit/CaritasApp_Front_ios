import SwiftUI

struct HomeView: View {
    let onNecesitoAyuda: () -> Void
    let onUnirmeAlEquipo: () -> Void
    let onQuieroDonar: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                CariTopBar()

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

import SwiftUI

/// Pantalla Ayuda: acceso al orientador y al directorio de centros, y datos de la oficina central.
struct HelpView: View {
    let onGuideTap: () -> Void
    let onViewCentersTap: () -> Void
    let onBack: () -> Void

    private let noticeGreen = Color(red: 0x2E / 255, green: 0x7D / 255, blue: 0x32 / 255)
    private let noticeBackground = Color(red: 0xE9 / 255, green: 0xF5 / 255, blue: 0xEC / 255)

    @Environment(\.openURL) private var openURL
    @State private var alertMessage: String?

    private var speakableText: String {
        helpSpeakableText()
    }

    var body: some View {
        VStack(spacing: 0) {
            CariTopBar(title: "Ayuda y ajustes", onBack: onBack, speakableText: speakableText)

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("¿En qué te podemos ayudar?")
                        .font(CariTypography.headlineLarge)
                        .foregroundStyle(Color.cariNavy)
                        .padding(.top, 20)
                        .padding(.bottom, 8)

                    Text("Elige una opción. Estamos para acompañarte.")
                        .font(CariTypography.bodyLarge)
                        .foregroundStyle(Color.cariNavy)
                        .padding(.bottom, 18)

                    VStack(spacing: 16) {
                        OptionCard(
                            systemImage: "questionmark.circle",
                            title: "No sé qué necesito",
                            description: "Te orientamos con unas preguntas.",
                            action: onGuideTap
                        )

                        OptionCard(
                            systemImage: "mappin.and.ellipse",
                            title: "Ver todos los centros",
                            description: "Consulta las ubicaciones de ayuda.",
                            action: onViewCentersTap
                        )

                        listenInfoCard

                        officeContactCard

                        noAccountBanner
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .background(Color.cariBackground)
        .alert(
            alertMessage ?? "",
            isPresented: Binding(
                get: { alertMessage != nil },
                set: { if !$0 { alertMessage = nil } }
            )
        ) {
            Button("Aceptar", role: .cancel) {}
        }
    }

    // MARK: - Bloques

    private var listenInfoCard: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .strokeBorder(Color.cariRed, lineWidth: 1.5)
                    .frame(width: 44, height: 44)
                Image(systemName: "speaker.wave.2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                    .foregroundStyle(Color.cariRed)
            }
            .accessibilityHidden(true)

            Text("En cada pantalla verás el botón Escuchar. Tócalo y la aplicación te leerá la información en voz alta.")
                .font(CariTypography.bodyLarge)
                .foregroundStyle(Color.cariNavy)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(18)
        .modifier(CardBackground(cornerRadius: 16))
    }

    private var officeContactCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(HelpContactConfig.officeName)
                .font(CariTypography.titleMedium)
                .foregroundStyle(Color.cariNavy)

            Text(HelpContactConfig.officeAddress)
                .font(CariTypography.bodyMedium)
                .foregroundStyle(Color.cariNavyMuted)

            Text("\(HelpContactConfig.officeWeekdays)\n\(HelpContactConfig.officeSaturday)")
                .font(CariTypography.bodyMedium)
                .foregroundStyle(Color.cariNavyMuted)

            Text("Para agendar una cita, llama o escríbenos por WhatsApp.")
                .font(CariTypography.bodyMedium)
                .foregroundStyle(Color.cariNavyMuted)

            SecondaryButton(
                title: "Llamar al \(HelpContactConfig.officePhoneLabel)",
                action: callOffice
            )
            SecondaryButton(title: "Escribir por WhatsApp", action: writeByWhatsApp)

            Text("WhatsApp: \(HelpContactConfig.whatsAppLabel)")
                .font(CariTypography.bodyMedium)
                .foregroundStyle(Color.cariNavyMuted)
        }
        .padding(18)
        .modifier(CardBackground(cornerRadius: 16))
    }

    private func callOffice() {
        open(
            HelpContactConfig.officePhoneURL,
            errorMessage: "No fue posible abrir la aplicación Teléfono en este dispositivo."
        )
    }

    private func writeByWhatsApp() {
        open(
            HelpContactConfig.whatsAppURL,
            errorMessage: "No fue posible abrir el enlace de WhatsApp en este dispositivo."
        )
    }

    /// Pide al sistema abrir el enlace; si no puede, muestra el aviso indicado.
    private func open(_ url: URL?, errorMessage: String) {
        guard let url else {
            alertMessage = errorMessage
            return
        }
        openURL(url) { accepted in
            if !accepted {
                alertMessage = errorMessage
            }
        }
    }

    private var noAccountBanner: some View {
        HStack(spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 22, height: 22)
                .foregroundStyle(noticeGreen)
                .accessibilityHidden(true)

            Text("Esta aplicación no te pide crear una cuenta ni compartir datos para recibir ayuda.")
                .font(CariTypography.bodyMedium)
                .foregroundStyle(Color.cariNavy)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(noticeBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.cariBorder, lineWidth: 1)
        )
    }
}

/// Fondo blanco con borde y esquinas redondeadas, común a las tarjetas de esta pantalla.
private struct CardBackground: ViewModifier {
    let cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.cariBackground)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(Color.cariBorder, lineWidth: 1)
            )
    }
}

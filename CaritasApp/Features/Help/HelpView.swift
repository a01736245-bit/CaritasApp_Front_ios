import SwiftUI

/// Pantalla Ayuda: una sola vista con acceso al orientador y al directorio de centros.
/// Todavía no hay datos de contacto confirmados, por lo que se muestran como pendientes.
struct HelpView: View {
    let onGuideTap: () -> Void
    let onViewCentersTap: () -> Void
    let onBack: () -> Void

    private let noticeGreen = Color(red: 0x2E / 255, green: 0x7D / 255, blue: 0x32 / 255)
    private let noticeBackground = Color(red: 0xE9 / 255, green: 0xF5 / 255, blue: 0xEC / 255)

    private var speakableText: String {
        joinSpeakable(
            "¿En qué te podemos ayudar?",
            "Elige una opción. Estamos para acompañarte.",
            "No sé qué necesito. Te orientamos con unas preguntas.",
            "Ver todos los centros. Consulta las ubicaciones de ayuda.",
            "En cada pantalla verás el botón Escuchar. Tócalo y la aplicación te leerá la información en voz alta.",
            "Teléfonos para llamar. Información de contacto pendiente de confirmar.",
            "¿Necesitas orientación o agendar una cita? Solo la clínica de diagnóstico requiere cita.",
            "Esta aplicación no te pide crear una cuenta ni compartir datos para recibir ayuda."
        )
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

                        phonesSection

                        orientationContactCard

                        noAccountBanner
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .background(Color.cariBackground)
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

    private var phonesSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Image(systemName: "phone")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                    .foregroundStyle(Color.cariRed)
                    .accessibilityHidden(true)
                Text("Teléfonos para llamar")
                    .font(CariTypography.titleMedium)
                    .foregroundStyle(Color.cariNavy)
            }

            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 12) {
                    Image(systemName: "phone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.cariNavyMuted)
                        .accessibilityHidden(true)
                    Text("Información de contacto pendiente de confirmar.")
                        .font(CariTypography.bodyMedium)
                        .foregroundStyle(Color.cariNavyMuted)
                }

                PrimaryButton(title: "Ver centros", action: onViewCentersTap)
            }
            .padding(16)
            .modifier(CardBackground(cornerRadius: 14))
        }
    }

    /// El número de WhatsApp todavía no está confirmado: el botón se muestra deshabilitado.
    private var orientationContactCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("¿Necesitas orientación o agendar una cita?")
                .font(CariTypography.titleMedium)
                .foregroundStyle(Color.cariNavy)

            Text("Escríbenos por WhatsApp y te ayudaremos a encontrar el servicio adecuado. Solo la clínica de diagnóstico requiere cita.")
                .font(CariTypography.bodyMedium)
                .foregroundStyle(Color.cariNavyMuted)
                .padding(.top, 6)
                .padding(.bottom, 16)

            PrimaryButton(
                title: "Solicitar orientación por WhatsApp",
                action: {},
                isEnabled: false
            )
        }
        .padding(18)
        .modifier(CardBackground(cornerRadius: 16))
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

import SwiftUI

/// Explica cómo postularse y abre el formulario externo. CARI Vita no captura,
/// guarda ni envía datos de la postulación, y no muestra confirmaciones de envío.
struct VolunteerApplicationInfoView: View {
    let onBack: () -> Void

    @Environment(\.openURL) private var openURL
    @State private var showOpenError = false

    private static let steps = [
        "Abre el formulario.",
        "Completa la información que te solicitan.",
        "Revisa tus respuestas.",
        "Presiona Enviar dentro del formulario."
    ]

    /// Texto fijo: nunca incluye la dirección del formulario.
    private var speakableText: String {
        var parts: [String?] = [
            "Cómo postularte",
            "Para participar como voluntario, completa el formulario de postulación."
        ]
        for (index, step) in Self.steps.enumerated() {
            parts.append("Paso \(index + 1). \(step)")
        }
        parts.append("El formulario se abrirá fuera de CARI Vita.")
        parts.append("CARI Vita no guarda los datos que escribas en el formulario.")
        parts.append("Botón: Abrir formulario.")
        return joinSpeakable(parts: parts)
    }

    var body: some View {
        VStack(spacing: 0) {
            CariTopBar(title: "Cómo postularte", onBack: onBack, speakableText: speakableText)

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Cómo postularte")
                        .font(CariTypography.headlineLarge)
                        .foregroundStyle(Color.cariNavy)
                        .padding(.top, 20)
                        .padding(.bottom, 8)

                    Text("Para participar como voluntario, completa el formulario de postulación.")
                        .font(CariTypography.bodyLarge)
                        .foregroundStyle(Color.cariNavy)
                        .padding(.bottom, 18)

                    VStack(alignment: .leading, spacing: 14) {
                        ForEach(Array(Self.steps.enumerated()), id: \.offset) { index, step in
                            NumberedStep(number: index + 1, text: step)
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
                    .padding(.bottom, 10)

                    notice(systemImage: "arrow.up.right.square", text: "El formulario se abrirá fuera de CARI Vita.")
                    notice(systemImage: "lock", text: "CARI Vita no guarda los datos que escribas en el formulario.")

                    PrimaryButton(
                        title: "Abrir formulario",
                        action: openForm,
                        systemImage: "arrow.up.right.square"
                    )
                    .padding(.top, 20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .background(Color.cariBackground)
        .alert("No fue posible abrir el formulario en este dispositivo.", isPresented: $showOpenError) {
            Button("Aceptar", role: .cancel) {}
        }
    }

    /// Abre el formulario fuera de la app y avisa solo si el sistema no pudo abrirlo.
    private func openForm() {
        guard let url = ExternalFormsConfig.volunteerFormURL else {
            showOpenError = true
            return
        }
        openURL(url) { accepted in
            if !accepted {
                showOpenError = true
            }
        }
    }

    private func notice(systemImage: String, text: String) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 10) {
            Image(systemName: systemImage)
                .frame(width: 22)
                .foregroundStyle(Color.cariNavyMuted)
                .accessibilityHidden(true)
            Text(text)
                .font(CariTypography.bodyLarge)
                .foregroundStyle(Color.cariNavyMuted)
        }
        .padding(.top, 10)
    }
}

private struct NumberedStep: View {
    let number: Int
    let text: String

    var body: some View {
        HStack(spacing: 14) {
            Text("\(number)")
                .font(CariTypography.titleMedium)
                .foregroundStyle(.white)
                .frame(width: 36, height: 36)
                .background(Color.cariRed, in: Circle())
                .accessibilityHidden(true)

            Text(text)
                .font(CariTypography.bodyLarge)
                .foregroundStyle(Color.cariNavy)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Paso \(number). \(text)")
    }
}

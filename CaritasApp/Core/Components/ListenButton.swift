import SwiftUI

/// Botón circular de lectura en voz alta. Con texto, lee o detiene la lectura mediante
/// `SpeechService`; sin texto (o sin servicio) permanece deshabilitado.
struct ListenButton: View {
    let speakableText: String?

    @Environment(SpeechService.self) private var speech: SpeechService?

    private var isSpeaking: Bool {
        speech?.isSpeaking ?? false
    }

    private var isEnabled: Bool {
        guard speech != nil, let speakableText else { return false }
        return !speakableText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        Button {
            if let speakableText {
                speech?.toggle(speakableText)
            }
        } label: {
            Image(systemName: isSpeaking ? "stop.fill" : "speaker.wave.2.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .foregroundStyle(.white)
                .frame(width: 60, height: 60)
                .background(Color.cariRed, in: Circle())
                .contentShape(Circle())
        }
        .buttonStyle(ListenButtonStyle())
        .disabled(!isEnabled)
        .accessibilityLabel(isSpeaking ? "Detener lectura" : "Escuchar contenido")
    }
}

/// Mantiene el aspecto del botón igual cuando está deshabilitado.
private struct ListenButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}

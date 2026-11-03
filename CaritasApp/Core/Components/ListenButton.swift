import SwiftUI

struct ListenButton: View {
    let onTap: () -> Void
    var isSpeaking: Bool = false
    // Deshabilitado hasta implementar la lectura en voz alta (Módulo 07).
    var isEnabled: Bool = false

    var body: some View {
        Button(action: onTap) {
            Image(systemName: isSpeaking ? "stop.fill" : "speaker.wave.2.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .foregroundStyle(.white)
        }
        .buttonStyle(ListenButtonStyle())
        .disabled(!isEnabled)
        .frame(width: 60, height: 60)
        .background(Color.cariRed, in: Circle())
        .accessibilityLabel(isSpeaking ? "Detener lectura" : "Escuchar pantalla")
    }
}

// Mantiene el aspecto del botón igual cuando está deshabilitado.
private struct ListenButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

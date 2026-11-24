import AVFoundation
import Observation
import os

/// Servicio único de lectura en voz alta. Mantiene un solo sintetizador y lee con
/// cualquier voz en español instalada, sin importar su género (ver `SpeechVoiceSelector`).
/// Sin pausa ni reanudación: la lectura se inicia o se detiene.
@Observable
final class SpeechService: NSObject, AVSpeechSynthesizerDelegate {

    static let noSpanishVoiceMessage = "No hay una voz en español disponible en este dispositivo. Revisa las voces instaladas en los ajustes de accesibilidad."
    static let audioUnavailableMessage = "No fue posible activar Escuchar en este dispositivo."

    /// Es true solo mientras el sintetizador está hablando de verdad.
    private(set) var isSpeaking = false

    /// Aviso para el usuario cuando no se puede iniciar una lectura.
    var showUnavailableAlert = false
    private(set) var alertMessage = SpeechService.noSpanishVoiceMessage

    @ObservationIgnored private let synthesizer = AVSpeechSynthesizer()
    /// Lectura vigente. Los avisos del sintetizador de lecturas anteriores se ignoran.
    @ObservationIgnored private var currentUtterance: AVSpeechUtterance?
    @ObservationIgnored private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "CaritasApp",
        category: "Speech"
    )

    override init() {
        super.init()
        synthesizer.delegate = self
    }

    /// Acción del botón "Escuchar": si está hablando, detiene; si no, lee `text`.
    func toggle(_ text: String) {
        if isSpeaking || synthesizer.isSpeaking {
            stop()
        } else {
            speak(text)
        }
    }

    /// Lee `text` con la voz elegida. Cualquier lectura anterior se detiene antes de empezar
    /// la nueva. Si no hay ninguna voz en español, no se inicia la lectura y se avisa.
    func speak(_ text: String) {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        stop()

        guard let voice = spanishVoice() else {
            logger.error("No hay ninguna voz en español disponible; no se inicia la lectura")
            present(Self.noSpanishVoiceMessage)
            return
        }

        guard activateAudioSession() else {
            present(Self.audioUnavailableMessage)
            return
        }

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = voice
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance.pitchMultiplier = 1.0
        currentUtterance = utterance
        synthesizer.speak(utterance)
    }

    func stop() {
        currentUtterance = nil
        if synthesizer.isSpeaking || synthesizer.isPaused {
            synthesizer.stopSpeaking(at: .immediate)
        }
        isSpeaking = false
        deactivateAudioSession()
    }

    private func present(_ message: String) {
        alertMessage = message
        showUnavailableAlert = true
    }

    // MARK: - Voz

    /// Voz elegida entre las instaladas en el dispositivo; no se descarga ninguna.
    private func spanishVoice() -> AVSpeechSynthesisVoice? {
        let installed = AVSpeechSynthesisVoice.speechVoices()
        let candidates = installed.map(SpeechVoiceInfo.init)

        guard let chosen = SpeechVoiceSelector.choose(from: candidates),
              let voice = installed.first(where: { $0.identifier == chosen.identifier }) else {
            return nil
        }

        logger.info("""
            Voz elegida: \(chosen.name, privacy: .public) \
            idioma=\(chosen.language, privacy: .public) \
            id=\(chosen.identifier, privacy: .public)
            """)
        return voice
    }

    // MARK: - Sesión de audio

    /// Se activa solo mientras se lee, para no ocupar la sesión de audio sin necesidad.
    private func activateAudioSession() -> Bool {
        #if os(iOS)
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .spokenAudio, options: [.duckOthers])
            try session.setActive(true)
        } catch {
            logger.error("No se pudo activar la sesión de audio: \(error.localizedDescription)")
            return false
        }
        #endif
        return true
    }

    private func deactivateAudioSession() {
        #if os(iOS)
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        #endif
    }

    // MARK: - AVSpeechSynthesizerDelegate

    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        let id = ObjectIdentifier(utterance)
        Task { @MainActor [weak self] in
            self?.utteranceDidStart(id)
        }
    }

    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        let id = ObjectIdentifier(utterance)
        Task { @MainActor [weak self] in
            self?.utteranceDidEnd(id)
        }
    }

    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        let id = ObjectIdentifier(utterance)
        Task { @MainActor [weak self] in
            self?.utteranceDidEnd(id)
        }
    }

    private func utteranceDidStart(_ id: ObjectIdentifier) {
        guard let current = currentUtterance, ObjectIdentifier(current) == id else { return }
        isSpeaking = true
        if let voice = current.voice {
            logger.info("Lectura iniciada con la voz \(voice.name, privacy: .public) (\(voice.identifier, privacy: .public))")
        }
    }

    private func utteranceDidEnd(_ id: ObjectIdentifier) {
        guard let current = currentUtterance, ObjectIdentifier(current) == id else { return }
        currentUtterance = nil
        isSpeaking = false
        deactivateAudioSession()
    }
}

// MARK: - Elección de voz

/// Datos de una voz instalada que se usan para elegirla.
struct SpeechVoiceInfo: Equatable {
    let identifier: String
    let name: String
    let language: String
    let quality: AVSpeechSynthesisVoiceQuality
    /// Voces de novedad o personales: no son adecuadas para una lectura normal.
    let isSpecialVoice: Bool

    init(
        identifier: String,
        name: String,
        language: String,
        quality: AVSpeechSynthesisVoiceQuality,
        isSpecialVoice: Bool = false
    ) {
        self.identifier = identifier
        self.name = name
        self.language = language
        self.quality = quality
        self.isSpecialVoice = isSpecialVoice
    }

    init(_ voice: AVSpeechSynthesisVoice) {
        self.init(
            identifier: voice.identifier,
            name: voice.name,
            language: voice.language,
            quality: voice.quality,
            isSpecialVoice: voice.voiceTraits.contains(.isNoveltyVoice)
                || voice.voiceTraits.contains(.isPersonalVoice)
        )
    }

    var isSpanish: Bool {
        language.lowercased().hasPrefix("es")
    }

    var isMexican: Bool {
        language.replacingOccurrences(of: "_", with: "-").lowercased() == "es-mx"
    }
}

/// Elige la voz de lectura entre las instaladas, sin restricción de género:
/// 1. Cualquier voz en español de México.
/// 2. Si no hay, cualquier otra voz en español.
/// Si no hay ninguna voz en español, devuelve nil. Dentro de cada grupo gana la de mayor
/// calidad, y luego el identificador, para que la elección sea siempre la misma.
enum SpeechVoiceSelector {

    static func choose(from voices: [SpeechVoiceInfo]) -> SpeechVoiceInfo? {
        let spanish = voices.filter { $0.isSpanish && !$0.isSpecialVoice }

        if let mexican = spanish.filter(\.isMexican).min(by: isPreferred) {
            return mexican
        }
        return spanish.min(by: isPreferred)
    }

    private static func isPreferred(_ first: SpeechVoiceInfo, over second: SpeechVoiceInfo) -> Bool {
        if first.quality.rawValue != second.quality.rawValue {
            return first.quality.rawValue > second.quality.rawValue
        }
        return first.identifier < second.identifier
    }
}

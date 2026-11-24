import Foundation

/// Texto estándar para una sección sin información confirmada.
let pendingSpeakableText = "Información pendiente de confirmar."

/// Une fragmentos en oraciones simples: descarta los vacíos o nulos y agrega un punto
/// a los que no terminan en ".", "?", "!" o ":".
func joinSpeakable(parts: [String?]) -> String {
    parts
        .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
        .filter { !$0.isEmpty }
        .map { part in
            [".", "?", "!", ":"].contains { part.hasSuffix($0) } ? part : part + "."
        }
        .joined(separator: " ")
}

func joinSpeakable(_ parts: String?...) -> String {
    joinSpeakable(parts: parts)
}

/// Teléfono pronunciado dígito por dígito, separado por comas.
func phoneForSpeech(_ phone: String) -> String {
    let digitNames = ["cero", "uno", "dos", "tres", "cuatro", "cinco", "seis", "siete", "ocho", "nueve"]
    return phone
        .compactMap { $0.wholeNumberValue }
        .map { digitNames[$0] }
        .joined(separator: ", ")
}

/// Resumen hablado de una lista de centros: cuántos hay y los nombres de los primeros.
/// Nunca lee la lista completa.
func centersSpeakableSummary(_ centers: [Center], maxNamed: Int = 3) -> String {
    guard !centers.isEmpty else {
        return "No encontramos centros confirmados para esta búsqueda todavía."
    }

    let count = centers.count
    let countText = count == 1 ? "Se encontró 1 centro." : "Se encontraron \(count) centros."
    let named = centers.prefix(maxNamed).map { "\($0.name)." }.joined(separator: " ")
    let remaining = count - min(count, maxNamed)
    let remainingText = remaining > 0 ? "Y \(remaining) más." : nil

    return joinSpeakable(countText, "Algunos de ellos:", named, remainingText)
}

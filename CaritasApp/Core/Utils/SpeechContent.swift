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
/// Con un servicio de origen, tras cada nombre se lee su horario si existe.
/// Nunca lee la lista completa.
func centersSpeakableSummary(_ centers: [Center], maxNamed: Int = 3, serviceId: String? = nil) -> String {
    guard !centers.isEmpty else {
        return "No encontramos centros confirmados para esta búsqueda todavía."
    }

    let count = centers.count
    let countText = count == 1 ? "Se encontró 1 centro." : "Se encontraron \(count) centros."
    let named = centers.prefix(maxNamed).map { center -> String in
        let schedules = center.highlightedSchedules(forServiceId: serviceId)
            .map { "Horario de \($0.service): \($0.schedule)" }
        return joinSpeakable(parts: [center.name] + schedules)
    }.joined(separator: " ")
    let remaining = count - min(count, maxNamed)
    let remainingText = remaining > 0 ? "Y \(remaining) más." : nil

    return joinSpeakable(countText, "Algunos de ellos:", named, remainingText)
}

/// Texto que se lee en el detalle de un centro: solo lo que la pantalla muestra, sin enlaces.
func centerDetailSpeakableText(_ center: Center) -> String {
    let zoneLine = [center.zone.map(formatZoneLabel), center.deanery]
        .compactMap { $0 }
        .joined(separator: ", ")

    let phones = center.phones.isEmpty
        ? nil
        : center.phones.map { "Teléfono: \(phoneForSpeech($0))" }.joined(separator: ". ")

    let responsibles = center.parishResponsibles.isEmpty
        ? nil
        : "Responsables de la parroquia. "
            + center.parishResponsibles.map { "\($0.role): \($0.name)" }.joined(separator: ". ")

    let services = center.services.isEmpty
        ? nil
        : "Servicios. "
            + center.services.map { key -> String in
                let name = displayServiceLabel(ExcelServiceCatalog.labelFor(key))
                if let schedule = center.schedule(forServiceKey: key) {
                    return "\(name). Días y horarios: \(schedule)"
                }
                return "\(name). Llama a esta parroquia para consultar días y horarios"
            }.joined(separator: ". ")
            + "."

    let otherBenefits = center.offersOtherBenefits
        ? joinSpeakable(
            "Otros beneficios.",
            center.otherBenefitsDetails?.trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty,
            otherBenefitsNotice
        )
        : nil

    return joinSpeakable(
        center.name,
        zoneLine,
        "Dirección: \(center.address)",
        phones,
        responsibles,
        services,
        otherBenefits
    )
}

/// Indicación que acompaña a la sección "Otros beneficios".
let otherBenefitsNotice = "Para conocer los apoyos disponibles, requisitos y horarios, llama a esta parroquia al teléfono indicado."

private extension String {
    var nilIfEmpty: String? { isEmpty ? nil : self }
}

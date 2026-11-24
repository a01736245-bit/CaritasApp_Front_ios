import Foundation

/// Da formato de lectura a una zona ("ZONA CENTRO" → "Zona Centro").
/// Solo cambia la presentación: el valor original se sigue usando para filtrar.
func formatZoneLabel(_ zone: String) -> String {
    if zone == CenterRepository.unregisteredZone {
        return "Centros sin zona registrada"
    }
    return zone.lowercased()
        .split(separator: " ", omittingEmptySubsequences: false)
        .map { $0.prefix(1).uppercased() + $0.dropFirst() }
        .joined(separator: " ")
}

/// Une los guiones de corte de línea de las etiquetas de servicio
/// ("Medicamen-tos" → "Medicamentos") cuando están entre dos letras minúsculas.
/// Si la etiqueta termina en una "Y" suelta ("Apoyo Psicológico Y") y lo que la
/// precede coincide con el título de un servicio del catálogo, usa ese título.
func displayServiceLabel(_ rawLabel: String) -> String {
    let joined = rawLabel.replacingOccurrences(
        of: "([a-záéíóúñ])-([a-záéíóúñ])",
        with: "$1$2",
        options: .regularExpression
    )
    guard joined.hasSuffix(" Y") else { return joined }

    let base = String(joined.dropLast(2))
    let confirmed = ServiceCatalog.categories
        .flatMap(\.services)
        .first { $0.title.caseInsensitiveCompare(base) == .orderedSame }
    return confirmed?.title ?? joined
}

extension Center {
    /// Horarios con texto de los servicios de CARI Vita consultados que ofrece el centro,
    /// como pares (nombre del servicio, horario). Vacío si no hay servicio o no hay horario.
    func highlightedSchedules(forServiceId serviceId: String?) -> [(service: String, schedule: String)] {
        guard let serviceId else { return [] }
        return ServiceExcelMapping.excelKeys(for: serviceId)
            .filter { services.contains($0) }
            .compactMap { key in
                schedule(forServiceKey: key).map { (displayServiceLabel(ExcelServiceCatalog.labelFor(key)), $0) }
            }
    }
}

extension Center {
    /// Responsables de la parroquia con contenido, en el orden de presentación.
    var parishResponsibles: [(role: String, name: String)] {
        [
            ("Párroco", parishPriest),
            ("Coordinador o coordinadora", coordinator),
            ("Secretario o secretaria", secretary),
            ("Tesorero o tesorera", treasurer),
            ("Vocal 1", vocal1),
            ("Vocal 2", vocal2),
            ("Vocal 3", vocal3)
        ].compactMap { role, name in
            guard let name = name?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty else { return nil }
            return (role, name)
        }
    }

    /// Indica si el centro ofrece "otros beneficios".
    var offersOtherBenefits: Bool {
        services.contains("otros_beneficios")
    }
}

/// Enlace telefónico para un número registrado. Acepta números con prefijo internacional
/// ("+...", o "52" seguido de diez dígitos) y números nacionales de diez dígitos, a los que
/// antepone +52. Devuelve nil si el número es ambiguo o no tiene un formato reconocible.
func phoneDialURL(_ phone: String) -> URL? {
    let trimmed = phone.trimmingCharacters(in: .whitespacesAndNewlines)
    let digits = trimmed.filter(\.isNumber)
    let international: String
    if trimmed.hasPrefix("+") {
        guard (8...15).contains(digits.count) else { return nil }
        international = digits
    } else if digits.count == 10 {
        international = "52" + digits
    } else if digits.count == 12, digits.hasPrefix("52") {
        international = digits
    } else {
        return nil
    }
    return URL(string: "tel:+\(international)")
}

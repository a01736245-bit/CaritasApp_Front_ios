import Foundation

/// Da formato de lectura a una zona ("ZONA CENTRO" → "Zona Centro").
/// Solo cambia la presentación: el valor original se sigue usando para filtrar.
func formatZoneLabel(_ zone: String) -> String {
    zone.lowercased()
        .split(separator: " ", omittingEmptySubsequences: false)
        .map { $0.prefix(1).uppercased() + $0.dropFirst() }
        .joined(separator: " ")
}

/// Une los guiones de corte de línea de las etiquetas de servicio
/// ("Medicamen-tos" → "Medicamentos") cuando están entre dos letras minúsculas.
func displayServiceLabel(_ rawLabel: String) -> String {
    rawLabel.replacingOccurrences(
        of: "([a-záéíóúñ])-([a-záéíóúñ])",
        with: "$1$2",
        options: .regularExpression
    )
}

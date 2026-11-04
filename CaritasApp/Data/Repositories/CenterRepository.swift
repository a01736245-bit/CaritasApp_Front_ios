import Foundation
import os

/// Consulta de centros ya cargados en memoria. Si la carga falla, `loadError`
/// guarda el motivo para que las pantallas muestren un aviso en lugar de
/// confundir el error con una búsqueda sin resultados.
struct CenterRepository {
    let centers: [Center]
    let loadError: Error?

    var didFailToLoad: Bool { loadError != nil }

    init(centers: [Center], loadError: Error? = nil) {
        self.centers = centers
        self.loadError = loadError
    }

    /// Repositorio compartido; `centers.json` se lee una sola vez.
    static let shared = CenterRepository.loadFromBundle()

    private static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "CaritasApp",
        category: "Centers"
    )

    static func decodeCenters(from data: Data) throws -> [Center] {
        try JSONDecoder().decode([Center].self, from: data)
    }

    static func loadFromBundle(_ bundle: Bundle = .main) -> CenterRepository {
        do {
            guard let url = bundle.url(forResource: "centers", withExtension: "json")
                ?? bundle.url(forResource: "centers", withExtension: "json", subdirectory: "Data") else {
                throw CocoaError(.fileNoSuchFile)
            }
            let data = try Data(contentsOf: url)
            return CenterRepository(centers: try decodeCenters(from: data))
        } catch {
            logger.error("No se pudo cargar centers.json: \(error.localizedDescription)")
            return CenterRepository(centers: [], loadError: error)
        }
    }

    func findAll() -> [Center] {
        centers
    }

    func findById(_ id: String?) -> Center? {
        centers.first { $0.id == id }
    }

    /// Zonas presentes en los centros, sin repetir y en orden alfabético.
    func zones() -> [String] {
        Array(Set(centers.compactMap(\.zone))).sorted()
    }

    /// Filtra por servicio y/o zona, ambos opcionales.
    /// - Sin filtros: todos los centros, en el orden del archivo.
    /// - Servicio: centros con alguna clave de `ServiceExcelMapping`; si el servicio
    ///   no tiene claves confirmadas, no se devuelve ningún centro.
    /// - Zona: igualdad exacta; los centros sin zona quedan fuera.
    func findByFilter(serviceId: String? = nil, zone: String? = nil) -> [Center] {
        let serviceKeys = serviceId.map { ServiceExcelMapping.excelKeys(for: $0) } ?? []

        return centers.filter { center in
            let matchesService: Bool
            if serviceId == nil {
                matchesService = true
            } else if serviceKeys.isEmpty {
                matchesService = false
            } else {
                matchesService = serviceKeys.contains { center.services.contains($0) }
            }

            let matchesZone = zone == nil || center.zone == zone
            return matchesService && matchesZone
        }
    }
}

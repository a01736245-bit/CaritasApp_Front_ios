import Foundation

/// Centro de atención de Cáritas, tal como aparece en `centers.json`.
/// `zone` y `deanery` pueden ser nulos. `services` contiene claves de servicio
/// (ver `ExcelServiceCatalog`), no textos para mostrar. `serviceSchedules` asocia
/// una clave de servicio con un horario en texto libre; puede faltar o venir vacío.
/// Los campos de responsables y `otherBenefitsDetails` son opcionales.
struct Center: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let zone: String?
    let deanery: String?
    let address: String
    let phones: [String]
    let services: [String]
    let mapsUrl: String?
    let serviceSchedules: [String: String]
    let otherBenefitsDetails: String?
    let parishPriest: String?
    let coordinator: String?
    let secretary: String?
    let treasurer: String?
    let vocal1: String?
    let vocal2: String?
    let vocal3: String?

    private enum CodingKeys: String, CodingKey {
        case id, name, zone, deanery, address, phones, services, mapsUrl
        case serviceSchedules, otherBenefitsDetails
        case parishPriest, coordinator, secretary, treasurer, vocal1, vocal2, vocal3
    }

    init(
        id: String,
        name: String,
        zone: String? = nil,
        deanery: String? = nil,
        address: String,
        phones: [String] = [],
        services: [String] = [],
        mapsUrl: String? = nil,
        serviceSchedules: [String: String] = [:],
        otherBenefitsDetails: String? = nil,
        parishPriest: String? = nil,
        coordinator: String? = nil,
        secretary: String? = nil,
        treasurer: String? = nil,
        vocal1: String? = nil,
        vocal2: String? = nil,
        vocal3: String? = nil
    ) {
        self.id = id
        self.name = name
        self.zone = zone
        self.deanery = deanery
        self.address = address
        self.phones = phones
        self.services = services
        self.mapsUrl = mapsUrl
        self.serviceSchedules = serviceSchedules
        self.otherBenefitsDetails = otherBenefitsDetails
        self.parishPriest = parishPriest
        self.coordinator = coordinator
        self.secretary = secretary
        self.treasurer = treasurer
        self.vocal1 = vocal1
        self.vocal2 = vocal2
        self.vocal3 = vocal3
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        zone = try container.decodeIfPresent(String.self, forKey: .zone)
        deanery = try container.decodeIfPresent(String.self, forKey: .deanery)
        address = try container.decode(String.self, forKey: .address)
        phones = try container.decodeIfPresent([String].self, forKey: .phones) ?? []
        services = try container.decodeIfPresent([String].self, forKey: .services) ?? []
        mapsUrl = try container.decodeIfPresent(String.self, forKey: .mapsUrl)
        serviceSchedules = try container.decodeIfPresent([String: String].self, forKey: .serviceSchedules) ?? [:]
        otherBenefitsDetails = try container.decodeIfPresent(String.self, forKey: .otherBenefitsDetails)
        parishPriest = try container.decodeIfPresent(String.self, forKey: .parishPriest)
        coordinator = try container.decodeIfPresent(String.self, forKey: .coordinator)
        secretary = try container.decodeIfPresent(String.self, forKey: .secretary)
        treasurer = try container.decodeIfPresent(String.self, forKey: .treasurer)
        vocal1 = try container.decodeIfPresent(String.self, forKey: .vocal1)
        vocal2 = try container.decodeIfPresent(String.self, forKey: .vocal2)
        vocal3 = try container.decodeIfPresent(String.self, forKey: .vocal3)
    }

    /// Horario del servicio tal como está registrado, o nil si falta o está vacío.
    func schedule(forServiceKey key: String) -> String? {
        guard let text = serviceSchedules[key],
              !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return nil }
        return text
    }

    /// Indica si el centro no tiene zona registrada.
    var hasNoRegisteredZone: Bool {
        zone?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true
    }

    /// Enlace de mapas del centro, solo si el texto es una URL válida.
    var mapsURL: URL? {
        mapsUrl.flatMap { URL(string: $0) }
    }
}

import Foundation

/// Centro de atención de Cáritas, tal como aparece en `centers.json`.
/// `zone` y `deanery` pueden ser nulos. `services` contiene claves de servicio
/// (ver `ExcelServiceCatalog`), no textos para mostrar.
struct Center: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let zone: String?
    let deanery: String?
    let address: String
    let phones: [String]
    let services: [String]
    let mapsUrl: String?

    private enum CodingKeys: String, CodingKey {
        case id, name, zone, deanery, address, phones, services, mapsUrl
    }

    init(
        id: String,
        name: String,
        zone: String? = nil,
        deanery: String? = nil,
        address: String,
        phones: [String] = [],
        services: [String] = [],
        mapsUrl: String? = nil
    ) {
        self.id = id
        self.name = name
        self.zone = zone
        self.deanery = deanery
        self.address = address
        self.phones = phones
        self.services = services
        self.mapsUrl = mapsUrl
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
    }

    /// Enlace de mapas del centro, solo si el texto es una URL válida.
    var mapsURL: URL? {
        mapsUrl.flatMap { URL(string: $0) }
    }
}

import Foundation

/// Categoría de servicios. Puede no tener servicios confirmados todavía.
struct ServiceCategory: Identifiable {
    let id: String
    let title: String
    let systemImage: String
    let services: [ServiceItem]

    init(id: String, title: String, systemImage: String, services: [ServiceItem] = []) {
        self.id = id
        self.title = title
        self.systemImage = systemImage
        self.services = services
    }
}

import Foundation

/// Artículo de la lista "¿Qué necesita Cáritas?". Los campos opcionales quedan
/// vacíos cuando no hay información confirmada: la pantalla de detalle no los inventa.
struct DonationItem: Identifiable {
    let id: String
    let title: String
    let systemImage: String
    let category: String?
    let conditions: String?
    let purpose: String?

    init(
        id: String,
        title: String,
        systemImage: String,
        category: String? = nil,
        conditions: String? = nil,
        purpose: String? = nil
    ) {
        self.id = id
        self.title = title
        self.systemImage = systemImage
        self.category = category
        self.conditions = conditions
        self.purpose = purpose
    }

    /// Indica si el artículo tiene al menos un dato de detalle confirmado.
    var hasInfo: Bool {
        category != nil || conditions != nil || purpose != nil
    }
}

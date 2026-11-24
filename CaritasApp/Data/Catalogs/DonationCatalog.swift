import Foundation

/// Artículos de donación. Solo "Leche en polvo" tiene información de detalle
/// confirmada; los demás se muestran con el aviso de información pendiente.
/// Ningún artículo tiene lugar de entrega confirmado.
enum DonationCatalog {

    static let items: [DonationItem] = [
        DonationItem(
            id: "leche_en_polvo",
            title: "Leche en polvo",
            systemImage: "shippingbox",
            category: "Alimentos",
            conditions: "Sin abrir y con fecha de caducidad vigente.",
            purpose: "Para las despensas de familias con niñas y niños pequeños."
        ),
        DonationItem(id: "paracetamol", title: "Paracetamol", systemImage: "shippingbox"),
        DonationItem(id: "cobijas", title: "Cobijas", systemImage: "shippingbox"),
        DonationItem(
            id: "jabon_articulos_higiene",
            title: "Jabón y artículos de higiene",
            systemImage: "shippingbox"
        ),
        DonationItem(id: "cuadernos_utiles", title: "Cuadernos y útiles", systemImage: "shippingbox")
    ]

    static func findById(_ id: String?) -> DonationItem? {
        items.first { $0.id == id }
    }
}

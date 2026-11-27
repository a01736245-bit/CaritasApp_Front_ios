import Foundation

/// Artículos de donación con su categoría, condiciones y propósito.
/// Ningún artículo tiene lugar de entrega confirmado.
enum DonationCatalog {

    static let items: [DonationItem] = [
        DonationItem(
            id: "Utensilios_de_cocina",
            title: "Utensilios de cocina",
            systemImage: "shippingbox",
            category: "Hogar y cocina",
            conditions: "Limpios, completos y en buen estado, sin óxido ni partes rotas.",
            purpose: "Apoyar la preparación de alimentos en comedores y hogares."
        ),
        DonationItem(
            id: "Alimentos_enlatados",
            title: "Alimentos enlatados no perecederos",
            systemImage: "shippingbox",
            category: "Alimentos",
            conditions: "Sin abrir, con fecha de caducidad vigente y etiqueta legible. Las latas deben estar sin abultamientos, fugas ni óxido.",
            purpose: "Complementar las despensas de personas y familias que necesitan apoyo alimentario."
        ),
        DonationItem(
            id: "Ropa_usada",
            title: "Ropa usada",
            systemImage: "shippingbox",
            category: "Ropa y calzado",
            conditions: "Lavada, seca y en buen estado, sin manchas ni rasgaduras.",
            purpose: "Brindar prendas de vestir a personas y familias que las necesitan."
        ),
        DonationItem(
            id: "Zapatos_usados",
            title: "Zapatos usados",
            systemImage: "shippingbox",
            category: "Ropa y calzado",
            conditions: "Limpios, en pares y en buen estado, con suelas firmes y sin partes despegadas.",
            purpose: "Proporcionar calzado para las actividades diarias de personas que lo necesitan."
        ),
        DonationItem(
            id: "Pasta_dental",
            title: "Pasta dental",
            systemImage: "shippingbox",
            category: "Higiene personal",
            conditions: "Nueva, sin abrir, con sello intacto y fecha de caducidad vigente.",
            purpose: "Apoyar la higiene bucal de las personas beneficiarias."
        ),
        DonationItem(
            id: "Detergente_ropa",
            title: "Detergente para ropa",
            systemImage: "shippingbox",
            category: "Limpieza",
            conditions: "En su envase original, cerrado, con etiqueta legible y sin fugas.",
            purpose: "Apoyar el lavado de ropa y otros textiles de uso diario."
        ),
        DonationItem(
            id: "Cloro",
            title: "Cloro",
            systemImage: "shippingbox",
            category: "Limpieza",
            conditions: "En su envase original, sin abrir, con etiqueta legible y sin fugas. No entregar mezclado con otros productos.",
            purpose: "Apoyar la limpieza y desinfección de superficies."
        ),
        DonationItem(
            id: "Productos_higiene",
            title: "Productos de higiene: desodorante, shampoo, jabón corporal, crema corporal",
            systemImage: "shippingbox",
            category: "Higiene personal",
            conditions: "Desodorante, shampoo, jabón corporal o crema corporal nuevos, sin abrir y en su envase original. Con fecha vigente cuando corresponda.",
            purpose: "Cubrir necesidades de aseo y cuidado personal de las personas beneficiarias."
        )
    ]

    static func findById(_ id: String?) -> DonationItem? {
        items.first { $0.id == id }
    }
}

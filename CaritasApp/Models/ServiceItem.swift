import Foundation

/// Párrafo dentro de una sección de detalle. `label` es opcional y se muestra
/// en negrita antes del texto. `isHighlighted` resalta el párrafo.
struct SectionParagraph: Identifiable {
    let id = UUID()
    let label: String?
    let text: String
    let isHighlighted: Bool

    init(label: String? = nil, text: String, isHighlighted: Bool = false) {
        self.label = label
        self.text = text
        self.isHighlighted = isHighlighted
    }
}

/// Sección desplegable del detalle de un servicio. Si `paragraphs` está vacío,
/// la sección muestra que la información está pendiente de confirmar.
struct ServiceDetailSection: Identifiable {
    let title: String
    let paragraphs: [SectionParagraph]

    var id: String { title }

    init(title: String, paragraphs: [SectionParagraph] = []) {
        self.title = title
        self.paragraphs = paragraphs
    }
}

/// Servicio que pertenece a una categoría (por ejemplo, "Recibir una despensa").
struct ServiceItem: Identifiable {
    let id: String
    let categoryId: String
    let title: String
    let shortDescription: String
    let systemImage: String
    let sections: [ServiceDetailSection]
}

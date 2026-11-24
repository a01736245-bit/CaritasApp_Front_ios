import Foundation

/// Oportunidades de voluntariado. Los detalles (descripción, lugar, horario, actividades,
/// requisitos y contacto) están pendientes de confirmar: no se registran ni se muestran
/// hasta que `showOpportunityDetails` se habilite.
enum VolunteerCatalog {

    /// Cambiar a `true` cuando Cáritas confirme la información de cada oportunidad.
    static let showOpportunityDetails = false

    static let opportunities: [VolunteerOpportunity] = [
        VolunteerOpportunity(
            id: "asilo",
            title: "Asilo",
            shortDescription: "Participa en actividades de apoyo a personas mayores.",
            systemImage: "person.2"
        ),
        VolunteerOpportunity(
            id: "bazar",
            title: "Bazar",
            shortDescription: "Colabora en las actividades del bazar.",
            systemImage: "person.2"
        ),
        VolunteerOpportunity(
            id: "estancia_infantil",
            title: "Estancia infantil",
            shortDescription: "Participa en actividades de apoyo a niñas y niños.",
            systemImage: "person.2"
        ),
        VolunteerOpportunity(
            id: "trabajo_social",
            title: "Trabajo social",
            shortDescription: "Colabora con el equipo que brinda apoyo a personas y familias.",
            systemImage: "person.2"
        ),
        VolunteerOpportunity(
            id: "paquetes_alimentarios",
            title: "Paquetes alimentarios",
            shortDescription: "Colabora en las actividades de apoyo alimentario.",
            systemImage: "person.2"
        ),
        VolunteerOpportunity(
            id: "comedores_palafox",
            title: "Comedores Palafox",
            shortDescription: "Colabora en las actividades de los comedores.",
            systemImage: "person.2"
        )
    ]

    static func findById(_ id: String?) -> VolunteerOpportunity? {
        opportunities.first { $0.id == id }
    }
}

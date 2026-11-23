import Foundation

/// Oportunidades de voluntariado. Solo "Apoyo en el comedor" tiene información
/// de detalle confirmada; las otras dos muestran únicamente descripción y horario.
enum VolunteerCatalog {

    static let opportunities: [VolunteerOpportunity] = [
        VolunteerOpportunity(
            id: "apoyo_comedor",
            title: "Apoyo en el comedor",
            shortDescription: "Ayuda a preparar y servir comida a las personas que asisten.",
            systemImage: "person.2",
            schedule: "Sábado, de 11:00 a 15:00",
            activities: ["Preparar alimentos", "Servir la comida", "Acompañar a las personas"],
            whoCanParticipate: "Personas mayores de 18 años con ganas de ayudar.",
            requirements: ["Puntualidad", "Buen trato con las personas"]
        ),
        VolunteerOpportunity(
            id: "dar_clases_apoyo",
            title: "Dar clases de apoyo",
            shortDescription: "Acompaña a estudiantes con sus tareas y materias escolares.",
            systemImage: "person.2",
            schedule: "Sábados, de 10:00 a 12:00"
        ),
        VolunteerOpportunity(
            id: "ordenar_donaciones",
            title: "Ordenar donaciones",
            shortDescription: "Ayuda a clasificar y acomodar ropa y productos donados.",
            systemImage: "person.2",
            schedule: "Miércoles, de 10:00 a 13:00"
        )
    ]

    static func findById(_ id: String?) -> VolunteerOpportunity? {
        opportunities.first { $0.id == id }
    }
}

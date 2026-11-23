import Foundation

/// Oportunidad de voluntariado. Los campos opcionales quedan vacíos cuando no hay
/// información confirmada: la pantalla de detalle no los muestra ni los inventa.
struct VolunteerOpportunity: Identifiable {
    let id: String
    let title: String
    let shortDescription: String
    let systemImage: String
    let location: String?
    let schedule: String?
    let activities: [String]
    let whoCanParticipate: String?
    let requirements: [String]
    let contact: String?

    init(
        id: String,
        title: String,
        shortDescription: String,
        systemImage: String,
        location: String? = nil,
        schedule: String? = nil,
        activities: [String] = [],
        whoCanParticipate: String? = nil,
        requirements: [String] = [],
        contact: String? = nil
    ) {
        self.id = id
        self.title = title
        self.shortDescription = shortDescription
        self.systemImage = systemImage
        self.location = location
        self.schedule = schedule
        self.activities = activities
        self.whoCanParticipate = whoCanParticipate
        self.requirements = requirements
        self.contact = contact
    }

    /// Indica si hay información de detalle confirmada. El horario no cuenta:
    /// se muestra aparte aunque el resto esté pendiente.
    var hasDetail: Bool {
        !activities.isEmpty || whoCanParticipate != nil || !requirements.isEmpty || contact != nil
    }
}

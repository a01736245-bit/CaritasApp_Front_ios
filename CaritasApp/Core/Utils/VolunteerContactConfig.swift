import Foundation

/// Contacto de WhatsApp para consultas de voluntariado. El enlace solo abre el chat:
/// no lleva mensaje y la persona decide qué escribir y si lo envía.
enum VolunteerContactConfig {

    static let whatsAppURLString = "https://wa.me/522222117330"

    static var whatsAppURL: URL? {
        URL(string: whatsAppURLString)
    }
}

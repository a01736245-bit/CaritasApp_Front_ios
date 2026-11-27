import Foundation

/// Contactos de Procuración de Fondos. Son distintos de los de Voluntariado.
enum DonationContactConfig {
    static let whatsAppPhone = "522225728964"
    static let whatsAppLabel = "222 572 89 64"
    static let phoneURLString = "tel:+522225133860"
    static let phoneLabel = "222 513 38 60"
    static let email = "procuracion@caritaspuebla.org"
    static let emailSubject = "Consulta sobre donativo en especie"

    static var phoneURL: URL? {
        URL(string: phoneURLString)
    }
}

/// Consulta de un donativo en especie, a partir de los textos libres de Concepto y Cantidad.
struct DonationInquiry {
    let concept: String
    let quantity: String

    init(concept: String, quantity: String) {
        self.concept = concept.trimmingCharacters(in: .whitespacesAndNewlines)
        self.quantity = quantity.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var hasConcept: Bool { !concept.isEmpty }
    var hasQuantity: Bool { !quantity.isEmpty }

    /// Solo uno de los dos campos tiene contenido.
    var isIncomplete: Bool { hasConcept != hasQuantity }

    /// Mensaje preparado; solo existe cuando ambos campos tienen contenido.
    var message: String? {
        guard hasConcept, hasQuantity else { return nil }
        return "Hola, me gustaría hacer un donativo en especie.\nConcepto: \(concept)\nCantidad: \(quantity)"
    }

    /// Enlace del chat de WhatsApp; incluye el mensaje solo si está completo.
    var whatsAppURL: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "wa.me"
        components.path = "/" + DonationContactConfig.whatsAppPhone
        if let message {
            components.percentEncodedQuery = "text=" + Self.encode(message)
        }
        return components.url
    }

    /// Enlace para redactar el correo; el cuerpo solo se incluye si el mensaje está completo.
    var mailURL: URL? {
        var string = "mailto:\(DonationContactConfig.email)?subject=\(Self.encode(DonationContactConfig.emailSubject))"
        if let message {
            let body = message
                .replacingOccurrences(of: "\r\n", with: "\n")
                .replacingOccurrences(of: "\n", with: "\r\n")
            string += "&body=\(Self.encode(body))"
        }
        return URL(string: string)
    }

    /// Codificación porcentual estricta: solo quedan sin codificar letras, números y `-._~`.
    private static func encode(_ text: String) -> String {
        let allowed = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~")
        return text.addingPercentEncoding(withAllowedCharacters: allowed) ?? ""
    }
}

import Foundation

/// Datos de contacto de la pantalla Ayuda. El teléfono de la oficina y el WhatsApp de Ayuda
/// son números distintos, y ambos son distintos de los de Voluntariado y Donaciones.
enum HelpContactConfig {
    static let officeName = "Oficina central de Cáritas Puebla"
    static let officeAddress = "13 Sur No. 1701, Col. Santiago, C.P. 72410, Puebla, Pue."
    static let officeWeekdays = "Lunes a viernes de 09:00 a 16:00 horas"
    static let officeSaturday = "Sábados de 09:00 a 15:00 horas"

    static let officePhoneLabel = "222 211 73 30"
    static let officePhoneURLString = "tel:+522222117330"

    static let whatsAppLabel = "+52 1 767 120 1387"
    static let whatsAppURLString = "https://wa.me/5217671201387"

    static var officePhoneURL: URL? { URL(string: officePhoneURLString) }
    static var whatsAppURL: URL? { URL(string: whatsAppURLString) }
}

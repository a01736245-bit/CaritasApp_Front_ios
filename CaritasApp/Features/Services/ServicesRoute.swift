import Foundation

/// Destinos de la pila de navegación de la pestaña Servicios.
enum ServicesRoute: Hashable {
    case category(id: String)
    case service(id: String)
    case guide
    case locationChoice(serviceId: String)
}

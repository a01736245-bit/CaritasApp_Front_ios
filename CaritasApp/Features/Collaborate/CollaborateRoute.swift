import Foundation

/// Destinos de la pila de navegación de la pestaña Colaborar.
enum CollaborateRoute: Hashable {
    case volunteerDetail(id: String)
    case volunteerApplication
}

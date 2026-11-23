import Foundation

/// Enlaces a formularios que se abren fuera de la app. CARI Vita no recibe ni
/// guarda lo que la persona escribe en ellos.
enum ExternalFormsConfig {

    /// ENLACE TEMPORAL: abre un formulario de prueba titulado "Cari vita".
    /// Debe sustituirse por el formulario oficial de Cáritas Puebla antes de publicar.
    static let volunteerFormURLString =
        "https://docs.google.com/forms/d/e/1FAIpQLSc6W1A_yRH_PBUiA_dev_c2pgQh_Ep2CdU82pioT3ZUOGUziA/viewform?usp=publish-editor"

    static var volunteerFormURL: URL? {
        URL(string: volunteerFormURLString)
    }
}

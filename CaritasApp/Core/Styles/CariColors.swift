import SwiftUI

// Paleta CARI Vita. Valores extraídos de Android Color.kt (Cari_Vita_UI_Aprobada.pdf).
// Referencia Android: 0xFFRRGGBB → Color(red: RR/255, green: GG/255, blue: BB/255)

extension Color {

    // Rojo principal de acción: botones primarios, iconos activos, énfasis.

    static let cariRed = Color(red: 190/255, green: 38/255, blue: 34/255)

    // Azul marino: estructura, títulos, iconos de navegación, bordes.

    static let cariNavy = Color(red: 18/255, green: 50/255, blue: 97/255)

    // Texto secundario/subtítulos sobre fondo blanco.

    static let cariNavyMuted = Color(red: 74/255, green: 91/255, blue: 120/255)

    // Fondo principal de la app (blanco puro).

    static let cariBackground = Color(red: 1, green: 1, blue: 1)

    // Borde sutil de tarjetas y separadores.

    static let cariBorder = Color(red: 229/255, green: 231/255, blue: 236/255)

    // Fondo cálido claro del contenedor de ilustración de Bienvenida.
    static let cariIllustrationBg = Color(red: 248/255, green: 244/255, blue: 238/255)

    // Rojo tenue para estados deshabilitados de botones primarios.

    static let cariRedDisabled = Color(red: 224/255, green: 166/255, blue: 164/255)
}

import Foundation

/// Preguntas y textos de resultado del orientador. Las preguntas con
/// `isTextVerified: false` tienen texto provisional pendiente de confirmar.
enum OrientationCatalog {

    static let questions: [OrientationQuestion] = [
        OrientationQuestion(
            id: "q1_comida",
            text: "¿Necesitas comida o productos básicos?",
            targetCategoryId: "comida",
            isTextVerified: true
        ),
        OrientationQuestion(
            id: "q2_salud",
            text: "¿Buscas atención para tu salud?",
            targetCategoryId: "salud",
            isTextVerified: true
        ),
        OrientationQuestion(
            id: "q3_talleres",
            text: "¿Te interesa tomar un curso, taller o seminario?",
            targetCategoryId: "talleres",
            isTextVerified: false
        ),
        OrientationQuestion(
            id: "q4_ropa",
            text: "¿Buscas ropa o artículos personales?",
            targetCategoryId: "ropa",
            isTextVerified: true
        ),
        OrientationQuestion(
            id: "q5_estancia_infantil",
            text: "¿Necesitas apoyo con el cuidado de niñas o niños?",
            targetCategoryId: "estancia-infantil",
            isTextVerified: false
        ),
        OrientationQuestion(
            id: "q6_apoyo_fisico",
            text: "¿Necesitas un aparato ortopédico o apoyo para moverte?",
            targetCategoryId: "apoyo_fisico",
            isTextVerified: false
        ),
        OrientationQuestion(
            id: "q7_desastres",
            text: "¿Necesitas ayuda por una emergencia o un desastre?",
            targetCategoryId: "desastres",
            isTextVerified: false
        ),
        OrientationQuestion(
            id: "q8_migrantes",
            text: "¿Eres una persona migrante y necesitas ayuda?",
            targetCategoryId: "migrantes",
            isTextVerified: false
        ),
        OrientationQuestion(
            id: "q9_acompanamiento",
            text: "¿Buscas apoyo emocional, espiritual o acompañamiento?",
            targetCategoryId: "acompanamiento-espiritual",
            isTextVerified: false
        )
    ]

    /// Título y mensaje breve que se muestran al recomendar cada categoría.
    private static let resultCopy: [String: (title: String, message: String)] = [
        "comida": ("Comida", "Despensas y comedores."),
        "salud": ("Salud", "Consultas y atención médica."),
        "ropa": ("Ropa", "Ropa y artículos personales."),
        "talleres": ("Talleres", "Cursos, talleres y actividades."),
        "estancia-infantil": ("Estancia infantil", "Cuidado y atención para niñas y niños."),
        "apoyo_fisico": ("Apoyo físico", "Aparatos ortopédicos y apoyo para tu movilidad."),
        "desastres": ("Asistencia a desastres", "Apoyo ante emergencias y desastres."),
        "migrantes": ("Auxilio a migrantes", "Ayuda para personas migrantes."),
        "acompanamiento-espiritual": ("Acompañamiento y apoyo espiritual", "Apoyo emocional, espiritual y acompañamiento.")
    ]

    static func resultFor(categoryId: String) -> OrientationResult? {
        guard let copy = resultCopy[categoryId] else { return nil }
        return OrientationResult(categoryId: categoryId, title: copy.title, message: copy.message)
    }

    /// Resultado que se muestra cuando ninguna respuesta permite recomendar una categoría.
    static let neutralResult = OrientationResult(
        categoryId: nil,
        title: "No pasa nada",
        message: "Puedes ver todos los servicios disponibles."
    )
}

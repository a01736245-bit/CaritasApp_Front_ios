import Foundation

/// "No estoy seguro" es neutral: nunca se interpreta como "Sí".
enum OrientationAnswerValue: Hashable {
    case yes
    case no
    case unsure
}

struct OrientationAnswer: Identifiable {
    let label: String
    let value: OrientationAnswerValue

    var id: OrientationAnswerValue { value }

    /// Las tres respuestas disponibles en todas las preguntas.
    static let standard = [
        OrientationAnswer(label: "Sí", value: .yes),
        OrientationAnswer(label: "No", value: .no),
        OrientationAnswer(label: "No estoy seguro", value: .unsure)
    ]
}

/// Pregunta del orientador. `targetCategoryId` es la categoría que se recomienda
/// cuando la respuesta es "Sí". `isTextVerified` indica si el texto está confirmado.
struct OrientationQuestion: Identifiable {
    let id: String
    let text: String
    let targetCategoryId: String
    let answers: [OrientationAnswer]
    let isTextVerified: Bool

    init(
        id: String,
        text: String,
        targetCategoryId: String,
        answers: [OrientationAnswer] = OrientationAnswer.standard,
        isTextVerified: Bool = true
    ) {
        self.id = id
        self.text = text
        self.targetCategoryId = targetCategoryId
        self.answers = answers
        self.isTextVerified = isTextVerified
    }
}

/// Resultado del orientador. `categoryId` es nil en el resultado neutral.
struct OrientationResult: Identifiable {
    let categoryId: String?
    let title: String
    let message: String

    var id: String { categoryId ?? title }
}

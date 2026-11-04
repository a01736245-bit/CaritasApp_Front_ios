import Foundation

/// Motor determinista del orientador, sin puntajes ni desempates.
/// Cada pregunta respondida "Sí" aporta su categoría, una sola vez y en el orden
/// de las preguntas. "No" y "No estoy seguro" nunca generan recomendaciones.
/// Una lista vacía significa que se debe mostrar el resultado neutral.
enum OrientationEngine {

    static func evaluate(
        answers: [String: OrientationAnswerValue],
        questions: [OrientationQuestion] = OrientationCatalog.questions
    ) -> [OrientationResult] {
        var seenCategoryIds = Set<String>()

        return questions
            .filter { answers[$0.id] == .yes }
            .map(\.targetCategoryId)
            .filter { seenCategoryIds.insert($0).inserted }
            .filter { ServiceCatalog.findCategory($0) != nil }
            .compactMap { OrientationCatalog.resultFor(categoryId: $0) }
    }
}

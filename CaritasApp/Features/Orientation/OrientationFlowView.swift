import SwiftUI

/// Cuestionario y resultado del orientador en un solo destino de navegación.
/// El estado vive aquí: cada vez que se abre el orientador empieza en la
/// pregunta 1 sin respuestas, y Atrás entre preguntas conserva lo respondido.
struct OrientationFlowView: View {
    let onExit: () -> Void
    let onOpenCategory: (String) -> Void

    @State private var currentIndex = 0
    @State private var answers: [String: OrientationAnswerValue] = [:]

    private let questions = OrientationCatalog.questions

    var body: some View {
        Group {
            if currentIndex < questions.count {
                let question = questions[currentIndex]
                OrientationQuestionView(
                    question: question,
                    questionNumber: currentIndex + 1,
                    totalQuestions: questions.count,
                    selectedAnswer: answers[question.id],
                    onAnswerSelected: { value in
                        answers[question.id] = value
                        currentIndex += 1
                    },
                    onBack: goBack
                )
                .id(question.id)
            } else {
                OrientationResultView(
                    results: OrientationEngine.evaluate(answers: answers, questions: questions),
                    onSeeCategory: onOpenCategory,
                    onSeeServices: onExit,
                    onBack: goBack
                )
            }
        }
        // Evita que el gesto del sistema salga del cuestionario sin pasar por las preguntas.
        .navigationBarBackButtonHidden(true)
    }

    private func goBack() {
        if currentIndex == 0 {
            onExit()
        } else {
            currentIndex -= 1
        }
    }
}

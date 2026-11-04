import SwiftUI

struct OrientationQuestionView: View {
    let question: OrientationQuestion
    let questionNumber: Int
    let totalQuestions: Int
    let selectedAnswer: OrientationAnswerValue?
    let onAnswerSelected: (OrientationAnswerValue) -> Void
    let onBack: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            CariTopBar(onBack: onBack)

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Pregunta \(questionNumber) de \(totalQuestions)")
                        .font(CariTypography.titleMedium)
                        .foregroundStyle(Color.cariNavy)
                        .padding(.top, 20)
                        .padding(.bottom, 8)

                    OrientationProgress(
                        currentQuestion: questionNumber,
                        totalQuestions: totalQuestions
                    )
                    .padding(.bottom, 22)

                    Text(question.text)
                        .font(CariTypography.headlineLarge)
                        .foregroundStyle(Color.cariNavy)
                        .padding(.bottom, 10)

                    Text("Elige la respuesta que más se acerque a lo que necesitas.")
                        .font(CariTypography.bodyLarge)
                        .foregroundStyle(Color.cariNavy)
                        .padding(.bottom, 26)

                    VStack(spacing: 14) {
                        ForEach(question.answers) { answer in
                            OrientationAnswerButton(
                                answer: answer,
                                isSelected: selectedAnswer == answer.value,
                                action: { onAnswerSelected(answer.value) }
                            )
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .background(Color.cariBackground)
    }
}

import SwiftUI

/// Barra de progreso del cuestionario: tramo rojo hasta la pregunta actual.
struct OrientationProgress: View {
    let currentQuestion: Int
    let totalQuestions: Int

    private var fraction: Double {
        guard totalQuestions > 0 else { return 0 }
        return min(max(Double(currentQuestion) / Double(totalQuestions), 0), 1)
    }

    var body: some View {
        Capsule()
            .fill(Color.cariBorder)
            .frame(height: 6)
            .overlay(alignment: .leading) {
                GeometryReader { geometry in
                    Capsule()
                        .fill(Color.cariRed)
                        .frame(width: geometry.size.width * fraction)
                }
            }
            .allowsHitTesting(false)
            .accessibilityElement()
            .accessibilityLabel("Progreso")
            .accessibilityValue("Pregunta \(currentQuestion) de \(totalQuestions)")
    }
}

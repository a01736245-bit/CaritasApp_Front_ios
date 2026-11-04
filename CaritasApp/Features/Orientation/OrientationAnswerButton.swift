import SwiftUI

/// Botón de respuesta del cuestionario. "Sí" es relleno rojo, "No" tiene contorno
/// y "No estoy seguro" es solo texto. La respuesta ya elegida muestra una marca.
struct OrientationAnswerButton: View {
    let answer: OrientationAnswer
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            label
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    @ViewBuilder
    private var label: some View {
        switch answer.value {
        case .yes:
            content(font: CariTypography.labelLarge, textColor: .white, checkColor: .white)
                .frame(height: 60)
                .background(Color.cariRed)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        case .no:
            content(font: CariTypography.labelLarge, textColor: Color.cariNavy, checkColor: Color.cariRed)
                .frame(height: 56)
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .strokeBorder(isSelected ? Color.cariRed : Color.cariBorder, lineWidth: 1.5)
                )
        case .unsure:
            content(
                font: CariTypography.titleMedium,
                textColor: isSelected ? Color.cariRed : Color.cariNavy,
                checkColor: Color.cariRed
            )
            .frame(height: 48)
        }
    }

    private func content(font: Font, textColor: Color, checkColor: Color) -> some View {
        HStack(spacing: 8) {
            Text(answer.label)
                .font(font)
                .foregroundStyle(textColor)
            if isSelected {
                Image(systemName: "checkmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .foregroundStyle(checkColor)
                    .accessibilityHidden(true)
            }
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
    }
}

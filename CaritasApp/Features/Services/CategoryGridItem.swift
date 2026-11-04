import SwiftUI

/// Celda de la cuadrícula de categorías: icono en círculo rojo y título debajo.
struct CategoryGridItem: View {
    let systemImage: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .strokeBorder(Color.cariRed, lineWidth: 1.5)
                        .frame(width: 64, height: 64)
                    Image(systemName: systemImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(Color.cariRed)
                }
                .accessibilityHidden(true)

                Text(title)
                    .font(CariTypography.titleMedium)
                    .foregroundStyle(Color.cariNavy)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 24)
            .padding(.horizontal, 12)
            .background(Color.cariBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color.cariBorder, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

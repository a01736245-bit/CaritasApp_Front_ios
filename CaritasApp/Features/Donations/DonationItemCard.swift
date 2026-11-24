import SwiftUI

/// Fila de un artículo en la lista de donaciones: icono, nombre y chevron.
struct DonationItemCard: View {
    let item: DonationItem
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .strokeBorder(Color.cariRed, lineWidth: 1.5)
                        .frame(width: 48, height: 48)
                    Image(systemName: item.systemImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.cariRed)
                }
                .accessibilityHidden(true)

                Text(item.title)
                    .font(CariTypography.titleMedium)
                    .foregroundStyle(Color.cariNavy)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.cariNavy)
                    .accessibilityHidden(true)
            }
            .padding(18)
            .background(Color.cariBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color.cariBorder, lineWidth: 1)
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

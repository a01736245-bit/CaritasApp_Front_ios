import SwiftUI

struct OptionCard: View {
    let systemImage: String
    let title: String
    let description: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: 0) {
                ZStack {
                    Circle()
                        .strokeBorder(Color.cariRed, lineWidth: 1.5)
                        .frame(width: 60, height: 60)
                    Image(systemName: systemImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color.cariRed)
                }

                Spacer().frame(width: 18)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(CariTypography.titleMedium)
                        .foregroundStyle(Color.cariNavy)
                    Text(description)
                        .font(CariTypography.bodyMedium)
                        .foregroundStyle(Color.cariNavyMuted)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer().frame(width: 8)

                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                    .foregroundStyle(Color.cariNavy)
            }
            .padding(20)
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

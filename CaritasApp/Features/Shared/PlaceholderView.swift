import SwiftUI

struct PlaceholderView: View {
    let title: String

    var body: some View {
        VStack(spacing: 0) {
            CariTopBar()

            Spacer()

            VStack(spacing: 0) {
                Image(systemName: "wrench.and.screwdriver")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .foregroundStyle(Color.cariNavyMuted)
                    .padding(.bottom, 16)

                Text(title)
                    .font(CariTypography.titleMedium)
                    .foregroundStyle(Color.cariNavy)
                    .multilineTextAlignment(.center)

                Text("Esta sección está en desarrollo. Próximamente estará disponible.")
                    .font(CariTypography.bodyMedium)
                    .foregroundStyle(Color.cariNavyMuted)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
            }
            .padding(32)

            Spacer()
        }
        .background(Color.cariBackground)
    }
}

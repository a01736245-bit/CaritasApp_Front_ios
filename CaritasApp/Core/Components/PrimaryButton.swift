import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var isEnabled: Bool = true
    var systemImage: String? = nil

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
                Text(title)
                    .font(CariTypography.labelLarge)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(isEnabled ? Color.cariRed : Color.cariRedDisabled)
            .clipShape(RoundedRectangle(cornerRadius: 30))
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
    }
}

import SwiftUI

struct CariTopBar: View {
    var title: String? = nil
    var onBack: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                if let onBack {
                    Button(action: onBack) {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color.cariNavy)
                    }
                    .frame(width: 52, height: 52)
                } else {
                    Spacer()
                        .frame(width: 52, height: 52)
                }

                if let title {
                    Text(title)
                        .font(CariTypography.titleMedium)
                        .foregroundStyle(Color.cariNavy)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 8)
                } else {
                    Spacer()
                }

                ListenButton(onTap: {})
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)

            Divider()
                .frame(height: 1)
                .overlay(Color.cariBorder)
        }
        .background(Color.cariBackground)
    }
}

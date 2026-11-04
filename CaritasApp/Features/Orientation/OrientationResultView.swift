import SwiftUI

struct OrientationResultView: View {
    let results: [OrientationResult]
    let onSeeCategory: (String) -> Void
    let onSeeServices: () -> Void
    let onBack: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            CariTopBar(onBack: onBack)

            ScrollView {
                VStack(spacing: 0) {
                    if results.isEmpty {
                        neutralContent
                    } else {
                        recommendationsContent
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .background(Color.cariBackground)
    }

    private var recommendationsContent: some View {
        VStack(spacing: 0) {
            Text("Te sugerimos estas opciones")
                .font(CariTypography.titleMedium)
                .foregroundStyle(Color.cariNavy)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)

            ForEach(results) { result in
                if let categoryId = result.categoryId {
                    recommendationCard(result: result, categoryId: categoryId)
                        .padding(.top, 16)
                }
            }

            SecondaryButton(title: "Regresar a las categorías", action: onSeeServices)
                .padding(.top, 20)
        }
    }

    private func recommendationCard(result: OrientationResult, categoryId: String) -> some View {
        VStack(spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .strokeBorder(Color.cariRed, lineWidth: 1.5)
                    .frame(width: 64, height: 64)
                if let category = ServiceCatalog.findCategory(categoryId) {
                    Image(systemName: category.systemImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color.cariRed)
                }
            }
            .accessibilityHidden(true)

            Text(result.title)
                .font(CariTypography.headlineLarge)
                .foregroundStyle(Color.cariNavy)
                .multilineTextAlignment(.center)
                .padding(.top, 14)

            Text(result.message)
                .font(CariTypography.bodyLarge)
                .foregroundStyle(Color.cariNavyMuted)
                .multilineTextAlignment(.center)
                .padding(.top, 6)

            PrimaryButton(title: "Ver esta opción", action: { onSeeCategory(categoryId) })
                .padding(.top, 18)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(Color.cariBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.cariBorder, lineWidth: 1)
        )
    }

    private var neutralContent: some View {
        let result = OrientationCatalog.neutralResult

        return VStack(spacing: 0) {
            VStack(spacing: 0) {
                Image(systemName: "wrench.and.screwdriver")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .foregroundStyle(Color.cariNavyMuted)
                    .accessibilityHidden(true)

                Text(result.title)
                    .font(CariTypography.headlineLarge)
                    .foregroundStyle(Color.cariNavy)
                    .multilineTextAlignment(.center)
                    .padding(.top, 18)

                Text(result.message)
                    .font(CariTypography.bodyLarge)
                    .foregroundStyle(Color.cariNavyMuted)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 32)
            .padding(.bottom, 28)

            PrimaryButton(title: "Ver servicios", action: onSeeServices)
        }
    }
}

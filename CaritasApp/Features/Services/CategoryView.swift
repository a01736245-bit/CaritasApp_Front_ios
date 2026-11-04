import SwiftUI

struct CategoryView: View {
    let category: ServiceCategory
    let onServiceTap: (String) -> Void
    let onBack: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            CariTopBar(onBack: onBack)

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center, spacing: 10) {
                        ZStack {
                            Circle()
                                .strokeBorder(Color.cariRed, lineWidth: 1.5)
                                .frame(width: 44, height: 44)
                            Image(systemName: category.systemImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 22)
                                .foregroundStyle(Color.cariRed)
                        }
                        .accessibilityHidden(true)

                        Text(category.title)
                            .font(CariTypography.headlineLarge)
                            .foregroundStyle(Color.cariNavy)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 8)

                    Text("Elige el servicio que necesitas. Estamos para acompañarte.")
                        .font(CariTypography.bodyLarge)
                        .foregroundStyle(Color.cariNavy)
                        .padding(.bottom, 18)

                    if category.services.isEmpty {
                        emptyState
                    } else {
                        VStack(spacing: 16) {
                            ForEach(category.services) { service in
                                OptionCard(
                                    systemImage: service.systemImage,
                                    title: service.title,
                                    description: service.shortDescription,
                                    action: { onServiceTap(service.id) }
                                )
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .background(Color.cariBackground)
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "wrench.and.screwdriver")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundStyle(Color.cariNavyMuted)
                .accessibilityHidden(true)

            Text("Aún no hay servicios confirmados para esta categoría.")
                .font(CariTypography.bodyLarge)
                .foregroundStyle(Color.cariNavyMuted)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 24)
    }
}

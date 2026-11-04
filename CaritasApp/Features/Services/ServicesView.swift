import SwiftUI

struct ServicesView: View {
    let onCategoryTap: (String) -> Void
    let onGuideTap: () -> Void
    let onBack: () -> Void

    /// La categoría de acompañamiento espiritual se muestra fuera de la cuadrícula.
    private static let spiritualCategoryId = "acompanamiento-espiritual"

    private let gridColumns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible())
    ]

    private var gridCategories: [ServiceCategory] {
        ServiceCatalog.categories.filter { $0.id != Self.spiritualCategoryId }
    }

    private var spiritualCategory: ServiceCategory? {
        ServiceCatalog.findCategory(Self.spiritualCategoryId)
    }

    var body: some View {
        VStack(spacing: 0) {
            CariTopBar(onBack: onBack)

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("¿Qué necesitas?")
                            .font(CariTypography.headlineLarge)
                            .foregroundStyle(Color.cariNavy)

                        Text("Elige la opción que mejor se acerque a lo que necesitas.")
                            .font(CariTypography.bodyLarge)
                            .foregroundStyle(Color.cariNavy)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 2)

                    LazyVGrid(columns: gridColumns, spacing: 16) {
                        ForEach(gridCategories) { category in
                            CategoryGridItem(
                                systemImage: category.systemImage,
                                title: category.title,
                                action: { onCategoryTap(category.id) }
                            )
                        }
                    }

                    if let spiritualCategory {
                        OptionCard(
                            systemImage: spiritualCategory.systemImage,
                            title: spiritualCategory.title,
                            description: "Conoce formas de recibir apoyo y acompañamiento.",
                            action: { onCategoryTap(spiritualCategory.id) }
                        )
                    }

                    OptionCard(
                        systemImage: "questionmark.circle",
                        title: "No sé cuál elegir",
                        description: "Podemos orientarte con unas preguntas.",
                        action: onGuideTap
                    )
                }
                .padding(.horizontal, 20)
                .padding(.top, 22)
                .padding(.bottom, 24)
            }
        }
        .background(Color.cariBackground)
    }
}

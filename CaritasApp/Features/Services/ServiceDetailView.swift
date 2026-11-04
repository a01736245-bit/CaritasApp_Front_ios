import SwiftUI

struct ServiceDetailView: View {
    let service: ServiceItem
    let onVerLugares: () -> Void
    let onBack: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            CariTopBar(title: service.title, onBack: onBack)

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text(service.title)
                        .font(CariTypography.headlineLarge)
                        .foregroundStyle(Color.cariNavy)
                        .padding(.top, 20)
                        .padding(.bottom, 18)

                    VStack(spacing: 14) {
                        ForEach(service.sections) { section in
                            InfoAccordion(
                                title: section.title,
                                paragraphs: section.paragraphs,
                                initiallyExpanded: section.id == service.sections.first?.id
                            )
                        }
                    }

                    PrimaryButton(
                        title: "Ver lugares",
                        action: onVerLugares,
                        systemImage: "mappin.circle.fill"
                    )
                    .padding(.top, 20)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .background(Color.cariBackground)
    }
}

import SwiftUI

struct ServiceDetailView: View {
    let service: ServiceItem
    let onVerLugares: () -> Void
    let onBack: () -> Void

    private var speakableText: String {
        let sections = service.sections.map { section -> String in
            let body = section.paragraphs.isEmpty
                ? pendingSpeakableText
                : section.paragraphs.map { joinSpeakable($0.label, $0.text) }.joined(separator: " ")
            return joinSpeakable(section.title, body)
        }
        return joinSpeakable(service.title, sections.joined(separator: " "))
    }

    var body: some View {
        VStack(spacing: 0) {
            CariTopBar(title: service.title, onBack: onBack, speakableText: speakableText)

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

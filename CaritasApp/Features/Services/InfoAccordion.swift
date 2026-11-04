import SwiftUI

/// Sección desplegable del detalle de un servicio. Sin párrafos muestra
/// que la información está pendiente de confirmar.
struct InfoAccordion: View {
    let title: String
    let paragraphs: [SectionParagraph]
    @State private var isExpanded: Bool

    init(title: String, paragraphs: [SectionParagraph], initiallyExpanded: Bool = false) {
        self.title = title
        self.paragraphs = paragraphs
        _isExpanded = State(initialValue: initiallyExpanded)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isExpanded.toggle()
                }
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    Text(title)
                        .font(CariTypography.titleMedium)
                        .foregroundStyle(Color.cariNavy)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundStyle(Color.cariNavy)
                        .accessibilityHidden(true)
                }
                .padding(.horizontal, 18)
                .padding(.vertical, 16)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityValue(isExpanded ? "Expandido" : "Contraído")

            if isExpanded {
                content
                    .padding(.horizontal, 18)
                    .padding(.bottom, 18)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.cariBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.cariBorder, lineWidth: 1)
        )
    }

    @ViewBuilder
    private var content: some View {
        if paragraphs.isEmpty {
            Text("Información pendiente de confirmar.")
                .font(CariTypography.bodyMedium)
                .foregroundStyle(Color.cariNavyMuted)
        } else {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(paragraphs) { paragraph in
                    VStack(alignment: .leading, spacing: 0) {
                        if let label = paragraph.label {
                            Text(label)
                                .font(CariTypography.bodyMedium)
                                .bold()
                                .foregroundStyle(Color.cariNavy)
                        }
                        if paragraph.isHighlighted {
                            Text(paragraph.text)
                                .font(CariTypography.titleMedium)
                                .foregroundStyle(Color.cariNavy)
                        } else {
                            Text(paragraph.text)
                                .font(CariTypography.bodyMedium)
                                .foregroundStyle(Color.cariNavyMuted)
                        }
                    }
                }
            }
        }
    }
}

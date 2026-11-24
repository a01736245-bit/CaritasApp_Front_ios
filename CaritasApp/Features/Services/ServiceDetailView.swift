import SwiftUI

struct ServiceDetailView: View {
    let service: ServiceItem
    let onVerLugares: () -> Void
    let onBack: () -> Void

    @Environment(\.openURL) private var openURL
    @State private var showCallError = false

    private var speakableText: String {
        let sections = service.sections.map { section -> String in
            let body = section.paragraphs.isEmpty
                ? pendingSpeakableText
                : section.paragraphs.map { joinSpeakable($0.label, $0.text) }.joined(separator: " ")
            let phone = section.contactPhone.map { "Teléfono: \(phoneForSpeech($0))" }
            return joinSpeakable(section.title, body, phone)
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
                        ForEach(Array(service.sections.enumerated()), id: \.element.id) { index, section in
                            InfoAccordion(
                                title: section.title,
                                paragraphs: section.paragraphs,
                                initiallyExpanded: index == 0 || section.contactPhone != nil,
                                callTitle: section.contactPhone.map { "Llamar al \($0)" },
                                onCall: section.contactPhone.map { phone in { call(phone) } }
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
        .alert("No fue posible abrir la aplicación Teléfono en este dispositivo.", isPresented: $showCallError) {
            Button("Aceptar", role: .cancel) {}
        }
    }

    /// Pide al sistema abrir el enlace telefónico; el usuario decide si realiza la llamada.
    private func call(_ phone: String) {
        let digits = phone.filter(\.isNumber)
        let international = digits.hasPrefix("52") && digits.count > 10 ? digits : "52" + digits
        guard let url = URL(string: "tel:+\(international)") else {
            showCallError = true
            return
        }
        openURL(url) { accepted in
            if !accepted {
                showCallError = true
            }
        }
    }
}

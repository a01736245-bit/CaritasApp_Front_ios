import SwiftUI

/// Contenido de la sección "Donar productos" dentro de Colaborar.
/// No incluye barra superior: la aporta la pantalla que lo contiene.
/// Los textos de Concepto y Cantidad los conserva quien contiene esta vista.
struct DonationsView: View {
    @Binding var concept: String
    @Binding var quantity: String
    let onItemTap: (String) -> Void

    static let title = "¿Qué necesita Cáritas?"
    static let subtitle = "Consulta algunos artículos que puedes donar y conoce su información disponible. También puedes revisar el directorio general de centros."
    static let procurementTitle = "Procuración de Fondos"
    static let procurementDescription = "Para consultar sobre un donativo en especie, escribe qué quieres donar y cuánto."

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(Self.title)
                .font(CariTypography.headlineLarge)
                .foregroundStyle(Color.cariNavy)

            Text(Self.subtitle)
                .font(CariTypography.bodyLarge)
                .foregroundStyle(Color.cariNavy)
                .padding(.top, 8)
                .padding(.bottom, 18)

            DonationContactCard(concept: $concept, quantity: $quantity)
                .padding(.bottom, 18)

            VStack(spacing: 16) {
                ForEach(DonationCatalog.items) { item in
                    DonationItemCard(item: item, action: { onItemTap(item.id) })
                }
            }
        }
    }
}

/// Tarjeta "Procuración de Fondos": dos campos de texto libre y las opciones de contacto.
/// Solo se prepara el mensaje; la persona decide si lo envía desde la otra aplicación.
private struct DonationContactCard: View {
    @Binding var concept: String
    @Binding var quantity: String

    @Environment(\.openURL) private var openURL
    @State private var alertMessage: String?

    private var inquiry: DonationInquiry {
        DonationInquiry(concept: concept, quantity: quantity)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(DonationsView.procurementTitle)
                .font(CariTypography.titleMedium)
                .foregroundStyle(Color.cariNavy)

            Text(DonationsView.procurementDescription)
                .font(CariTypography.bodyMedium)
                .foregroundStyle(Color.cariNavyMuted)

            field(label: "Concepto", placeholder: "Frijol", text: $concept)
            field(label: "Cantidad", placeholder: "5 kg", text: $quantity)

            if inquiry.isIncomplete {
                Text("Completa Concepto y Cantidad para preparar el mensaje.")
                    .font(CariTypography.bodyMedium)
                    .foregroundStyle(Color.cariNavyMuted)
            }

            PrimaryButton(
                title: "WhatsApp \(DonationContactConfig.whatsAppLabel)",
                action: openWhatsApp,
                isEnabled: !inquiry.isIncomplete
            )
            SecondaryButton(
                title: "Llamar al \(DonationContactConfig.phoneLabel)",
                action: call
            )
            SecondaryButton(title: DonationContactConfig.email, action: composeEmail)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.cariBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.cariBorder, lineWidth: 1)
        )
        .alert(
            alertMessage ?? "",
            isPresented: Binding(
                get: { alertMessage != nil },
                set: { if !$0 { alertMessage = nil } }
            )
        ) {
            Button("Aceptar", role: .cancel) {}
        }
    }

    private func openWhatsApp() {
        open(inquiry.whatsAppURL, errorMessage: "No fue posible abrir el enlace de WhatsApp en este dispositivo.")
    }

    private func call() {
        open(DonationContactConfig.phoneURL, errorMessage: "No fue posible abrir la aplicación Teléfono en este dispositivo.")
    }

    private func composeEmail() {
        if inquiry.isIncomplete {
            alertMessage = "Completa Concepto y Cantidad."
            return
        }
        open(inquiry.mailURL, errorMessage: "No fue posible abrir el correo en este dispositivo.")
    }

    /// Pide al sistema abrir el enlace; si no puede, muestra el aviso indicado.
    private func open(_ url: URL?, errorMessage: String) {
        guard let url else {
            alertMessage = errorMessage
            return
        }
        openURL(url) { accepted in
            if !accepted {
                alertMessage = errorMessage
            }
        }
    }

    private func field(label: String, placeholder: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(CariTypography.bodyMedium)
                .foregroundStyle(Color.cariNavyMuted)
                .accessibilityHidden(true)
            TextField(placeholder, text: text)
                .font(CariTypography.bodyLarge)
                .foregroundStyle(Color.cariNavy)
                .padding(.horizontal, 14)
                .frame(minHeight: 52)
                .background(Color.cariBackground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(Color.cariBorder, lineWidth: 1)
                )
                .accessibilityLabel(label)
        }
        .padding(.top, 4)
    }
}

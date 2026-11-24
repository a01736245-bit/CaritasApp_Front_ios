import SwiftUI

/// Detalle de un artículo de donación. Solo muestra los datos confirmados;
/// sin ninguno, aparece el aviso de información pendiente.
struct DonationItemDetailView: View {
    let item: DonationItem
    let onConsultCenters: () -> Void
    let onBack: () -> Void

    private var speakableText: String {
        joinSpeakable(
            item.title,
            item.category.map { "Categoría: \($0)" },
            item.conditions.map { "Características o condiciones: \($0)" },
            item.purpose.map { "¿Para qué se usa? \($0)" },
            item.hasInfo ? nil : pendingSpeakableText
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            CariTopBar(title: item.title, onBack: onBack, speakableText: speakableText)

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text(item.title)
                        .font(CariTypography.headlineLarge)
                        .foregroundStyle(Color.cariNavy)
                        .padding(.top, 20)
                        .padding(.bottom, 18)

                    infoCard

                    Text("Puedes consultar el directorio de centros. La recepción de este artículo no está confirmada; verifica directamente con el centro antes de acudir.")
                        .font(CariTypography.bodyMedium)
                        .foregroundStyle(Color.cariNavyMuted)
                        .padding(.top, 16)

                    PrimaryButton(
                        title: "Consultar centros",
                        action: onConsultCenters,
                        systemImage: "mappin.circle.fill"
                    )
                    .padding(.top, 16)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .background(Color.cariBackground)
    }

    private var infoCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            if let category = item.category {
                labeledText(label: "Categoría", value: category)
            }
            if let conditions = item.conditions {
                labeledText(label: "Características o condiciones", value: conditions)
            }
            if let purpose = item.purpose {
                labeledText(label: "¿Para qué se usa?", value: purpose)
            }
            if !item.hasInfo {
                Text("Información pendiente de confirmar.")
                    .font(CariTypography.bodyLarge)
                    .foregroundStyle(Color.cariNavyMuted)
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.cariBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.cariBorder, lineWidth: 1)
        )
    }

    private func labeledText(label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(CariTypography.bodyMedium)
                .foregroundStyle(Color.cariNavyMuted)
            Text(value)
                .font(CariTypography.titleMedium)
                .bold()
                .foregroundStyle(Color.cariNavy)
        }
    }
}

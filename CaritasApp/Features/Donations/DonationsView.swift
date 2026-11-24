import SwiftUI

/// Contenido de la sección "Donar productos" dentro de Colaborar.
/// No incluye barra superior: la aporta la pantalla que lo contiene.
struct DonationsView: View {
    let onItemTap: (String) -> Void

    static let title = "¿Qué necesita Cáritas?"
    static let subtitle = "Consulta algunos artículos que puedes donar y conoce su información disponible. También puedes revisar el directorio general de centros."

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

            VStack(spacing: 16) {
                ForEach(DonationCatalog.items) { item in
                    DonationItemCard(item: item, action: { onItemTap(item.id) })
                }
            }
        }
    }
}

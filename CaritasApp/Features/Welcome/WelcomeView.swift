import SwiftUI

struct WelcomeView: View {
    let onEmpezar: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    ZStack {
                        Circle()
                            .fill(Color.cariRed)
                            .frame(width: 28, height: 28)
                        Image(systemName: "heart.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            .foregroundStyle(.white)
                    }

                    Spacer().frame(width: 6)

                    Text("CARI")
                        .font(CariTypography.titleMedium)
                        .foregroundStyle(Color.cariNavy)
                    Text(" Vita")
                        .font(CariTypography.titleMedium)
                        .foregroundStyle(Color.cariRed)

                    Spacer()

                    ListenButton(onTap: {})
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)

                VStack(alignment: .leading, spacing: 0) {
                    GeometryReader { geo in
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.cariIllustrationBg)
                            Image(systemName: "person.3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 56, height: 56)
                                .foregroundStyle(Color.cariNavyMuted)
                        }
                        .frame(width: geo.size.width, height: geo.size.width)
                    }
                    .aspectRatio(1, contentMode: .fit)

                    Spacer().frame(height: 26)

                    Text("Bienvenido\na CARI Vita")
                        .font(CariTypography.headlineLarge)
                        .foregroundStyle(Color.cariNavy)

                    Spacer().frame(height: 10)

                    Text("Una aplicación de Cáritas Puebla")
                        .font(CariTypography.titleMedium)
                        .foregroundStyle(Color.cariRed)

                    Spacer().frame(height: 14)

                    Text("¡Únete a nuestra causa y sé un héroe para un desprotegido!")
                        .font(CariTypography.bodyLarge)
                        .foregroundStyle(Color.cariNavy)

                    Spacer().frame(height: 30)

                    PrimaryButton(title: "Empezar", action: onEmpezar)

                    Spacer().frame(height: 18)

                    Text("Puedes consultar la información sin crear una cuenta.")
                        .font(CariTypography.bodyMedium)
                        .foregroundStyle(Color.cariNavyMuted)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)

                    Spacer().frame(height: 24)
                }
                .padding(.horizontal, 24)
            }
        }
        .background(Color.cariBackground)
    }
}

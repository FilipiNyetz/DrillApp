import SwiftUI

struct ProgressBarMedal: View {
    @State var porcentagemSkill: Double

    let medalPositions: [Double] = [25, 50, 75, 100]

    var body: some View {
        VStack(spacing: 4) {
            ZStack(alignment: .leading) {
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        // Fundo da barra
                        Rectangle()
                            .frame(width: geometry.size.width, height: 8)
                            .foregroundColor(Color("darkGray"))
                            .cornerRadius(8)

                        // Progresso preenchido
                        Rectangle()
                            .frame(
                                width: min(porcentagemSkill / 100 * geometry.size.width,
                                           geometry.size.width),
                                height: 8
                            )
                            .foregroundColor(Color("primary"))
                            .cornerRadius(8)

                        // Medalhas ao longo da barra
                        ForEach(medalPositions, id: \.self) { percent in
                            if porcentagemSkill < percent {
                                Image("medalha\(Int(percent))")
                                    .resizable()
                                    .frame(width: 20, height: 28)
                                    .position(
                                        x: CGFloat(percent / 100) * geometry.size.width,
                                        y: 24 // sobe um pouco acima da barra
                                    )
                            }
                        }
                    }
                }
            }
            .frame(width: 282, height: 30) // aumenta a altura total para acomodar as medalhas acima
        }
        .padding(.bottom, 12)
    }
}

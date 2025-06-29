import SwiftUI

struct ProgressBarMedal: View {
    @State var porcentagemSkill: Double

    let medalPositions: [Double] = [25, 50, 75, 100]

    var body: some View {
        VStack(spacing: 4) {
            ZStack(alignment: .leading) {
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        
                        Rectangle()
                            .frame(width: geometry.size.width, height: 8)
                            .foregroundColor(Color("darkGray"))
                            .cornerRadius(8)

                        
                        Rectangle()
                            .frame(
                                width: min(porcentagemSkill / 100 * geometry.size.width,
                                           geometry.size.width),
                                height: 8
                            )
                            .foregroundColor(Color("primary"))
                            .cornerRadius(8)

                        
                        ForEach(medalPositions, id: \.self) { percent in
                            if porcentagemSkill < percent {
                                Image("medalha\(Int(percent))")
                                    .resizable()
                                    .frame(width: 20, height: 28)
                                    .position(
                                        x: CGFloat(percent / 100) * geometry.size.width,
                                        y: 24
                                    )
                            }
                        }
                    }
                }
            }
            .frame(width: 282, height: 30)
        }
        .padding(.bottom, 12)
    }
}

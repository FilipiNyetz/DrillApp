import SwiftUI

struct ProgressBarCustom: View {
    @Binding var progress: Double
    
    var body: some View {
        HStack {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Fundo da barra
                    Rectangle()
                        .frame(width: geometry.size.width, height: 16)
                        .foregroundColor(Color("darkGray"))
                        .cornerRadius(8)
                    
                    if progress >= 1.0 {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .frame(
                                width: max(1.0 * geometry.size.width, 18),
                                height: 16
                            )
                            .foregroundColor(Color("primary"))
                            .clipShape(
                                RoundedCorner(
                                    radius: 8,
                                    corners: progress >= 1.0 ? .allCorners : [.topLeft, .bottomLeft]
                                )
                            )
                    }else if progress > 0 {
                        // Barra de progresso
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .frame(
                                width: max(progress * geometry.size.width, 18),
                                height: 16
                            )
                            .foregroundColor(Color("primary"))
                            .clipShape(
                                RoundedCorner(
                                    radius: 8,
                                    corners: progress >= 1.0 ? .allCorners : [.topLeft, .bottomLeft]
                                )
                            )
                    }
                }
            }
        }
        .frame(width: 280)
        .padding(.bottom, 12)
    }
    
    
}


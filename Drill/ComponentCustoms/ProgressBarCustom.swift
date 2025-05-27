//
//  ProgressBarCustom.swift
//  Drill
//
//  Created by Filipi Romão on 16/05/25.
//

import SwiftUI

struct ProgressBarCustom: View {
    @State var progress: CGFloat = 0.22
    var body: some View {
        HStack{
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: 16)
                        .opacity(1)
                        .foregroundColor(Color("darkGray"))
                        .cornerRadius(8)
                    
                    Rectangle()
                        .frame(
                            width: min(progress * geometry.size.width,
                                       geometry.size.width),
                            height: 16
                        )
                        .cornerRadius(8)
                        .foregroundColor(Color("primary"))
//                    Image("Medalha25")
//                        .resizable()
//                        .frame(width: 18,height: 26)
//                        .position(x: 63, y: 14)
//                    Image("Medalha50")
//                        .resizable()
//                        .frame(width: 18,height: 26)
//                        .position(x: 133, y: 14)
//                    Image("Medalha75")
//                        .resizable()
//                        .frame(width: 18,height: 26)
//                        .position(x: 202, y: 14)
//                    
//                    Image("Medalha100")
//                        .resizable()
//                        .frame(width: 18,height: 26)
//                        .position(x: 270, y: 14)
                    
                }
            }
        }.frame(width: 280)
            .padding(.bottom, 12)
    }
}



//
//  ProgressBarCustom.swift
//  Drill
//
//  Created by Filipi Romão on 16/05/25.
//

import SwiftUI

struct SkillProgressBar: View {
    var skill: SkillProgress
    
    var body: some View {
        
        HStack{
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle() 
                        .frame(width: geometry.size.width, height: 8)
                        .opacity(1)
                        .foregroundColor(Color("darkGray"))
                        .cornerRadius(8)
                    
                    Rectangle()
                        .frame(
                            width: min(skill.progress/100 * geometry.size.width,
                                       geometry.size.width),
                            height: 8
                        )
                        .cornerRadius(8)
                        .foregroundColor(Color("primary"))
                    
                }
            }
        }.frame(width: 280,height: 8)
            .padding(.bottom, 12)
    }
}



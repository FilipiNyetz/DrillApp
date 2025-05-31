//
//  sliderSkill.swift
//  Drill
//
//  Created by Filipi Romão on 14/05/25.
//

import SwiftUI

struct sliderSkill: View {
    @Binding var skillValue : Double
    var name : String
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(name): \(Int(skillValue))%").font(.system(size: 20, weight: .semibold))
            HStack{
                Button(action:{skillValue-=1}){
                    Image(systemName:"minus").foregroundColor(Color.white)
                }
                
                Slider(value: $skillValue,in: 0...100,step: 1){
                    Text("Speed")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("100")
                } onEditingChanged: { editing in
                    skillValue = skillValue
                }.frame(width: 264).tint(.white)
                
                Button(action:{skillValue+=1}){
                    Image(systemName:"plus").foregroundColor(Color.white)
                }
            }
            
        }.padding(.vertical,8)
    }
}


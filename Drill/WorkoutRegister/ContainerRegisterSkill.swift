//
//  ContainerRegisterSkill.swift
//  Drill
//
//  Created by Filipi Romão on 19/05/25.
//

import SwiftUI
import SwiftData

struct ContainerRegisterSkill: View {
    @State var buttonSelected: Bool = false
    @State var teste: Int = 0
    @State var modality: Modality
    var body: some View {
        
        ForEach(modality.skillsModality, id: \.self){
            skill in
            VStack(alignment: .leading, spacing: 8){
                
                VStack(alignment: .leading){
                    Text("\(skill.name)").font(.system(size: 22, weight: .bold))
                    Text("Domínio: \(Int(skill.progress))%").font(.system(size: 16,weight: .regular))
                }.padding(.leading)
                
                HStack(alignment: .center){
                    SkillProgressBar(skill: skill)
                }.frame(maxWidth: .infinity)
                
                CheckBoxButtons(skill: skill)
                
            }.frame(width: 320, height: 128)
                .background(Color("secondary"))
                .cornerRadius(8)
                .foregroundColor(Color("text"))
                .padding(.horizontal)
            
        }
        
        
    }
}


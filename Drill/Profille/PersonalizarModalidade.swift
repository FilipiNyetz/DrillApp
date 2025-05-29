//
//  PersonalizarModalidade.swift
//  Drill
//
//  Created by Filipi Romão on 27/05/25.
//

import SwiftUI
import SwiftData

struct PersonalizarModalidade: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var modality: Modality
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").ignoresSafeArea()
                VStack{
                    Text("\(modality.nameModality)")
                    Text("\(modality.skillsModality)")
                    Text("\(modality.belt)")
                    headerOnboard2()
                    Spacer()
                    ZStack{
                        Color("secondary")
                            .frame(width: 368, height: 439)
                            .cornerRadius(16)
                        ScrollView{
                            VStack(spacing: 12){
                                ForEach($modality.skillsModality, id: \.self) { $skill in
                                    sliderSkill(skillValue: $skill.progress, name: skill.name)
                                }
                            }.padding(.vertical, 8)
                        }.frame(width: 368, height: 439)
                        .foregroundColor(.white)
                        
                    }
                    Spacer()
                    VStack{
                        
                        Button(action: {
                            for skill in modality.skillsModality{
                                skill.updateMedal(progress: skill.progress)
                                modelContext.insert(skill)
                                try! modelContext.save()
                                
                                dismiss()
                                
                            }
                        }) {
                            Text("Concluir")
                        }
                        .frame(width: 218, height: 49)
                        .background(Color("primary"))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .font(.system(size: 18, weight: .bold))
                    }
                }.foregroundColor(.white).padding(.top,24).padding(.bottom,36)
            }
        }
        
    }
}



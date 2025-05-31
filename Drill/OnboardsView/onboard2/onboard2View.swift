//
//  onboard2.swift
//  Drill
//
//  Created by Filipi Romão on 14/05/25.
//

import SwiftUI
import SwiftData

public struct Onboard2: View {
    @AppStorage("visualizouOnboarding") var visualizouOnboarding: Bool = false
    
    @State private var nextPage: Bool = false

    @Environment(\.modelContext) private var modelContext
    @State var modality: Modality
    
    
    public var body: some View {
        
        NavigationStack{
            ZStack{
                Color("background").ignoresSafeArea()
                VStack{
                    HeaderOnboard2(modality: modality)
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
                            }.padding(.vertical, 4)
                        }.frame(width: 368, height: 439)
                        
                    }
                    Spacer()
                    VStack{
                        
                        Button(action: {
                            nextPage = true
                            visualizouOnboarding = true
                            for skill in modality.skillsModality{
                                skill.updateMedal(progress: skill.progress)
                                modelContext.insert(skill)
                                try! modelContext.save()
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
                    .navigationDestination(isPresented: $nextPage) {
                        
                    }
                }.foregroundColor(.white).padding(.bottom,36)
            }
        }
       

        
    }
    
    
    
}

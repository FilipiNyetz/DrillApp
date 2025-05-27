//
//  CheckBoxButtons.swift
//  Drill
//
//  Created by Filipi Romão on 19/05/25.
//

import SwiftUI
import SwiftData

struct CheckBoxButtons: View {
    var skill: SkillProgress
    @Environment(\.modelContext) private var modelContext
//    @AppStorage("botaoTreinouClicado") var cliqueTreinou: Bool = false
//    @AppStorage("botaoAplicouClicado") var cliqueAplicou: Bool = false
    
    var body: some View {
        HStack(alignment: .center){
            Button(action:{
                skill.treinou.toggle()
                
                if skill.treinou{
                    skill.progress+=1
                }else{
                    skill.progress-=1
                }
                skill.updateMedal(progress: skill.progress)
                try? modelContext.save()
                
                
            }){
                HStack {
                    Image(systemName: skill.treinou ? "checkmark.circle" : "circle") // ← alterna
                        .foregroundColor(.white)
                    Text("Treinou")
                }
                
            }
            Button(action:{
                
                skill.aplicou.toggle()
                if skill.aplicou{
                    skill.progress+=2
                }else{
                    skill.progress-=2
                }
                skill.updateMedal(progress: skill.progress)
                try? modelContext.save()
            }){
                HStack {
                    Image(systemName: skill.aplicou ? "checkmark.circle" : "circle") // ← alterna
                        .foregroundColor(.white)
                    Text("Aplicou")
                }
                
            }
        }.frame(width: 300)
            .font(.system(size: 20,weight: .regular))
        
        
    }
}



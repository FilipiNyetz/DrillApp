//
//  ContentView.swift
//  Drill
//
//  Created by Filipi Romão on 13/05/25.
//

import SwiftUI
import SwiftData

struct onboard1View: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query private var modalities: [Modality]
    @State private var modality = Modality(nameModality: "Jiu-Jitsu", belt: "Branca", graduation: "Lisa", skillsModality: [])
    
    
    @State private var nextPage: Bool = false
    
    
    
    var body: some View {
        
        
        let modalities: [String] = ["Jiu-Jitsu","Judo","Muay-thai","Boxe"]
        
        let beltsBJJ: [String] = ["Branca","Azul","Roxa","Marrom","Preta"]
        let beltsJudo: [String] = ["Branca","Branca/Cinza", "Cinza", "Cinza/Azul","Azul","Azul/Amarela","Amarela","Amarela/Laranja","Laranja","Verde","Roxa","Marrom","Preta"]
        let beltsMuayThai: [String] = ["Branca","Vermelho/Branco","Vermelho","Vermelho/Azul claro" , "Azul claro", "Azul claro/ Azul escuro", "Azul escuro", "Azul escuro/Preto","Preto","Preto/Branco" ,"Preto/Branco/Vermelho"]
        
        let graduations: [String] = ["lisa","1º grau","2º grau","3º grau","4º grau","5º grau"]
        NavigationStack {
            
            ZStack {
                Color("background").ignoresSafeArea().foregroundColor(.white)
                VStack{
                    HStack {
                        headerOnboard1()
                        Spacer()
                    }.padding(.top,24)
                    Spacer()
                    VStack(spacing: 24){
                        CelulaPersonalizar(options: modalities, context: "Modalidade", element: $modality.nameModality).padding(.top,16) //Chama a celula para o primeiro input ("Informe sua modalidade")
                        switch modality.nameModality {
                        case "Judo":
                            //Chama a celula e passa as opcoes do faixa do judo e qual valor será preenchido no element
                            
                            CelulaPersonalizar(options: beltsJudo,context: "Faixa", element: $modality.belt).padding(.top,16)
                            
                            
                        case "Muay-thai":
                            CelulaPersonalizar(options: beltsMuayThai,context: "Faixa", element: $modality.belt).padding(.top,16)
                        case "Boxe":
                            Text("")
                        default:
                            //Chama a celula e passa as opcoes do faixa do JJ e qual valor será preenchido no element
                            CelulaPersonalizar(options: beltsBJJ,context: "Faixa", element: $modality.belt).padding(.top,16)
                            //Chama a celula e passa as possiveis graduacoes
                            CelulaPersonalizar(options: graduations,context: "Graduação", element: $modality.graduation).padding(.top,16)
                        }
                    }
                    Spacer()
                    
                    VStack{
                        Button(action: {
                            nextPage = true
                            modelContext.insert(modality)
                            
                            try! modelContext.save()
                            //                            for index in users{
                            //                                modelContext.delete(index)
                            //                            }
                            //loop que remove todos os users
                        }) {
                            Text("Próximo")
                            Image(systemName: "arrow.right")
                        }
                        .frame(width: 218, height: 49)
                        .background(Color("primary"))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .font(.system(size: 18, weight: .bold))
                        .padding(.bottom,36)
                    }
                    
                    
                }
                .navigationDestination(isPresented: $nextPage) {
                    Onboard2(modality: modality)
                }
            }
            
        }.tint(.white)
            .onChange(of: modality.nameModality) { oldValue, newValue in
                modality.belt = "Branca"
                modality.graduation = "Lisa" // reset opcional para consistência
                
                var newSkills: [SkillProgress] = []
                
                switch newValue {
                case "Jiu-Jitsu":
                    newSkills = bjjSkills.map { SkillProgress(name: $0, progress: 0.0, medal: "nenhuma") }
                case "Judo":
                    newSkills = judoSkills.map { SkillProgress(name: $0, progress: 0.0, medal: "nenhuma") }
                case "Muay-thai":
                    newSkills = muayThaiSkills.map { SkillProgress(name: $0, progress: 0.0, medal: "nenhuma") }
                case "Boxe":
                    newSkills = boxingSkills.map { SkillProgress(name: $0, progress: 0.0, medal: "nenhuma") }
                default:
                    newSkills = []
                }
                
                // Força a substituição total do array
                modality.skillsModality = []
                modality.skillsModality.append(contentsOf: newSkills)
            }
        
            .onAppear(){
                if modality.skillsModality.isEmpty {
                    switch modality.nameModality {
                    case "Jiu-Jitsu":
                        modality.skillsModality = bjjSkills.map { SkillProgress(name: $0, progress: 0.0, medal: "nenhuma") }
                    case "Judo":
                        modality.skillsModality = judoSkills.map { SkillProgress(name: $0, progress: 0.0, medal: "nenhuma") }
                    case "Muay-thai":
                        modality.skillsModality = muayThaiSkills.map { SkillProgress(name: $0, progress: 0.0, medal: "nenhuma") }
                    case "Boxe":
                        modality.skillsModality = boxingSkills.map { SkillProgress(name: $0, progress: 0.0, medal: "nenhuma") }
                    default:
                        break
                    }
                }
            }
        
        
        
    }
}
//#Preview {
//    onboard1View()
//        .modelContainer(for: UserData.self, inMemory: true)
//}

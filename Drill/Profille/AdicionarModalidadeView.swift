//
//  AdicionarModalidadeView.swift
//  Drill
//
//  Created by Filipi Romão on 27/05/25.
//

import SwiftUI

struct AdicionarModalidadeView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var modality = Modality(nameModality: "", belt: "", graduation: "", skillsModality: [])
    @State private var navegarParaProximaEtapa = false
    
    @State private var annualGoalText: String = ""
    
    
    var camposInvalidos: Bool {
        modality.nameModality.isEmpty || modality.belt.isEmpty ||
        (modality.nameModality != "Boxe" && modality.graduation.isEmpty) ||
        !isValidGoalDays(annualGoalText)
    }
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color("background").ignoresSafeArea().foregroundColor(.white)
                VStack{
                    Text("Adicione uma nova modalidade").foregroundColor(Color("text"))
                        .font(.system(size: 24, weight: .bold))
                        .padding(.top,24)
                    Spacer()
                    VStack(alignment: .leading, spacing: 28) {
                        CelulaPersonalizar(options: modalitiesList, context: "Modalidade", element: $modality.nameModality)
                        Group {
                            switch modality.nameModality {
                            case "Judo":
                                CelulaPersonalizar(options: beltsJudo, context: "Faixa", element: $modality.belt)
                            case "Muay-thai":
                                CelulaPersonalizar(options: beltsMuayThai, context: "Faixa", element: $modality.belt)
                            case "Boxe":
                                EmptyView() // Nenhum input adicional
                            default:
                                CelulaPersonalizar(options: beltsBJJ, context: "Faixa", element: $modality.belt)
                                CelulaPersonalizar(options: graduations, context: "Graduação", element: $modality.graduation)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Insira sua meta de treinos anual")
                                .foregroundColor(Color("text"))
                                .font(.system(size: 18, weight: .semibold))
                            
                            TextFieldView(annualGoalText: $annualGoalText)
                                .border(Color("darkGray"))
                        }
                    }
                    .padding(.top, 16)
                    Spacer()
                    VStack{
                        Button(action: {
                            navegarParaProximaEtapa = true
                            modality.goalDays = Int(annualGoalText) ?? 00
                            modelContext.insert(modality)//Insere o model de modalidade, no modelContext
                            
                            try! modelContext.save()//salva o que tem
                        }) {
                            Text("Próximo")
                            Image(systemName: "arrow.right")
                        }
                        .frame(width: 218, height: 49)
                        .background(camposInvalidos ? Color.gray : Color("primary"))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .font(.system(size: 18, weight: .bold))
                        .padding(.bottom,36)
                        .disabled(camposInvalidos)
                    }
                }.navigationBarBackButtonHidden(true)
                    .navigationDestination(isPresented: $navegarParaProximaEtapa) {
                        PersonalizarModalidade(modality: modality)
                    }
            }.onChange(of: modality.nameModality) { oldValue, newValue in //Sempre que alterar os inputs chama aqui
                modality.belt = "Branca"
                modality.graduation = "Lisa" // reset opcional para consistência
                
                var newSkills: [SkillProgress] = [] //Array de novas skills
                
                switch newValue {
                case "Jiu-Jitsu":
                    newSkills = bjjSkills.map { SkillProgress(name: $0, progress: 0.0, medal: "nenhuma") }//Realiza um map em todos os elementos do array bjjSkills e para cada elemento seta os valores iniciais
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
                modality.skillsModality.append(contentsOf: newSkills) //Insere o valor de novas skills com estrutura skillProgress no array de skills do model modalidade
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
    func isValidGoalDays(_ text: String) -> Bool {
        guard let value = Int(text), value >= 1 else {
            return false
        }
        return true
    }
    
    
}

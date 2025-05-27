//
//  ProfileView.swift
//  Drill
//
//  Created by Filipi Romão on 16/05/25.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    
    @Environment(\.modelContext) private var modelContext
    @State var modality: Modality
    
    
    let modalities: [String] = ["Jiu-Jitsu","Judo","Muay-thai","Boxe"]
    
    let beltsBJJ: [String] = ["Branca","Azul","Roxa","Marrom","Preta"]
    let beltsJudo: [String] = ["Branca","Branca/Cinza", "Cinza", "Cinza/Azul","Azul","Azul/Amarela","Amarela","Amarela/Laranja","Laranja","Verde","Roxa","Marrom","Preta"]
    let beltsMuayThai: [String] = ["Branca","Vermelho/Branco","Vermelho","Vermelho/Azul claro" , "Azul claro", "Azul claro/ Azul escuro", "Azul escuro", "Azul escuro/Preto","Preto","Preto/Branco" ,"Preto/Branco/Vermelho"]
    
    
    var body: some View {
        ZStack {
            Color("background").ignoresSafeArea()
            VStack{
                VStack {
                    Text("Perfil de evolução").foregroundColor(Color("text"))
                        .font(.system(size: 26, weight: .bold))
                }.frame(maxWidth: 346, alignment: .leading)
                    .padding(.top, 24)
                    .padding(.bottom, 24)
                Spacer()
                VStack {
                    CelulaPersonalizar(options: modalities, context: "Modalidade", element: $modality.nameModality)
                    Spacer()
                    switch modality.nameModality {
                    case "Judo":
                        //Chama a celula e passa as opcoes do faixa do judo e qual valor será preenchido no element
                        CelulaPersonalizar(options: beltsJudo,context: "Faixa", element: $modality.belt)
                        
                    case "Muay-thai":
                        CelulaPersonalizar(options: beltsMuayThai,context: "Faixa", element: $modality.belt)
                        
                    case "Jiu-Jitsu":
                        CelulaPersonalizar(options: beltsBJJ,context: "Faixa", element: $modality.belt)
                    case "Boxe":
                        Text("")
                    default:
                        Text("")
                        
                    }
                }.frame(height: 230)
                Spacer()
                VStack(alignment: .leading) {
                    
                    Text("Suas insígnias de evolução").foregroundColor(Color("text"))
                        .font(.system(size: 20, weight: .semibold)).padding(.bottom,8)
                    ZStack {
                        Color("backgroundBoardMedal")
                        
                        // Aqui você vai usar LazyVGrid para mostrar todos os skills em grid
                        
                        ScrollView{
                            LazyVGrid(
                                columns: [
                                    GridItem(.flexible(),spacing: 20), // primeira coluna
                                    GridItem(.flexible()), // segunda coluna (pode ajustar número de colunas)
                                    // Adicione mais colunas se quiser
                                ],
                                spacing: 16 // espaço entre as células
                            ) {
                                ForEach(modality.skillsModality, id: \.self) { skill in
                                    if skill.progress >= 25 {
                                        ViewMedal(
                                            nomeSkill: skill.name,
                                            porcentagemSkill: skill.progress,
                                            medalha: skill.medal
                                        )
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                    .frame(width: 360, height: 184)
                    
                }.padding(.bottom, 54)
                
            }
       }
//            .onChange(of: user.modality) { oldValue, newValue in
//            modality.belt = "Branca"
            
//            switch user.modality {
//            case "Jiu-Jitsu":
//                instanciarSkill(bjjSkills)
//                
//            case "Boxe":
//                instanciarSkill(boxingSkills)
//                
//            case "Muay-thai":
//                instanciarSkill(muayThaiSkills)
//                
//            case "Judo":
//                instanciarSkill(judoSkills)
//                
//            default:
//                break
//            }
            
        }
        
    }
//    func instanciarSkill(_ modality:[String]){
//        generatedSkills = modality.map({SkillProgress(name: $0, progress:0.0, medal: "nenhuma", modality: user.modality, user: user)})
//    }



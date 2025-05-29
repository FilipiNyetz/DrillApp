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
    
    @State private var mostrarModal = false
    
    var body: some View {
        
        ZStack {
            Color("background").ignoresSafeArea()
            VStack{
                
                VStack {
                    HStack{
                        Text("Perfil de evolução").foregroundColor(Color("text"))
                            .font(.system(size: 26, weight: .bold))
                        Spacer()
                        Button(action: {
                            mostrarModal = true
                        }) {
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Color.gray.opacity(0.1))
                                .clipShape(Circle())
                        }
                    }
                }.frame(maxWidth: 346, alignment: .leading)
                    .padding(.top, 24)
                    .padding(.bottom, 24)
                Spacer()
                VStack {
                    MenuMyModalities(modalitySelected: $modality)
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
        .sheet(isPresented: $mostrarModal) {
            AdicionarModalidadeView()
        }
        
        
        
    }
   
}

//
//  homeView.swift
//  Drill
//
//  Created by Filipi Romão on 15/05/25.
//

import SwiftUI
import SwiftData

struct homeView: View {
    @State var currentDate: Date = Date()
//    @Binding var skills: [String : Double]
    @State private var sendWorkoutPage: Bool = false
    @Environment(\.modelContext) private var modelContext
    
    @State var modality: Modality
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color("background").ignoresSafeArea()
                VStack{
                    VStack(alignment: .leading, spacing: 8){
                        Text("Seu progresso nos treinos")
                            .foregroundColor(Color("text"))
                            .font(.system(size: 26, weight: .bold))
                        Text("Você já completou 10 treinos este ano")
                            .foregroundColor(Color("text"))
                            .font(.system(size: 17, weight: .regular))
                    }.frame(maxWidth: 346, alignment: .leading)
                        .padding(.top, 24)
                        .padding(.bottom, 24)
                    Spacer()
                   
                    ViewProgress()
                    Spacer()
                    CustomCalendarView()
                    Spacer()

                    Button(action:{
                        sendWorkoutPage = true
                    }){
                        Image(systemName: "dot.scope")
                        Text("Registrar treino")
                    }
                    .frame(width: 218, height: 49)
                    .foregroundStyle(.white)
                        .background(Color("primary"))
                        .cornerRadius(12)
                        .font(.system(size: 18, weight: .semibold))
                        .padding(.top,38)
                        .padding(.bottom,36)
                        
                    
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $sendWorkoutPage) {
                WorkoutView(modality:modality)
            }
        }
    }
}



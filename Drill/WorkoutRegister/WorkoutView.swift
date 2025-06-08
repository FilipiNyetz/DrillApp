//
//  WorkoutView.swift
//  Drill
//
//  Created by Filipi Romão on 16/05/25.
//

import SwiftUI
import SwiftData


struct WorkoutView: View {
//    @Binding var skills: [String : Double]
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State var teste :Int = 0
    @State var modality: Modality
    
    
    var today: Date = Date()
    
    @Binding var registeredWorkouts:[WorkoutData]
    
    var body: some View {
        
        ZStack{
            Color("background").ignoresSafeArea()
            VStack(){
                VStack(alignment: .leading,spacing: 16){
                    Text("Suas habilidades")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(Color("text"))
                    VStack(alignment: .leading){
                        Text(today.formatted(
                            Date.FormatStyle()
                                .locale(Locale(identifier: "pt_BR"))
                                .day()
                                .month(.abbreviated)
                        ))
                        Text(today.formatted(
                               Date.FormatStyle()
                                   .locale(Locale(identifier: "pt_BR"))
                                   .weekday(.wide)
                           ))
                    }.frame(maxWidth: 346, alignment: .leading).foregroundStyle(Color("text"))
                        .font(.system(size: 17,weight: .semibold))
                    
                }.padding(.leading)
                    .padding(.top,24)
                Spacer()
                
                ScrollView{
                    VStack(spacing: 8){
                        ContainerRegisterSkill(modality:modality)
                    }
                }.frame(maxHeight: .infinity)
                    .frame(maxWidth: .infinity)
                    
                Spacer()
                
                Button(action: {
                    // Atualizar progresso e status
                    if modality.trainedToday == false {
                        modality.totalDaysTrained += 1
                        // Para cada skill treinada, criar e salvar um WorkoutData
                        for skill in modality.skillsModality where skill.treinou || skill.aplicou {
                            let workout = WorkoutData(skill: skill)
                            workout.treinou = skill.treinou
                            workout.aplicou = skill.aplicou
                            modelContext.insert(workout)
                            modality.datesRegistered.append(workout)
                        }
                    }

                    modality.trainedToday = true
                    modality.lastTrainedDate = Date()
                    modality.updateProgress()

                    // Salvar tudo
                    try? modelContext.save()
                    dismiss()
                }) {
                    Image(systemName: "checkmark")
                    Text("Registrado")
                }
                .frame(width: 218, height: 49)
                .foregroundStyle(.white)
                .background(Color("primary"))
                .cornerRadius(12)
                .font(.system(size: 18, weight: .semibold))
                .padding(.top, 38)
                .padding(.bottom, 36)

                
                
                
            }
        }
    }
}


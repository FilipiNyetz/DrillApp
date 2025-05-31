//
//  WorkoutView.swift
//  Drill
//
//  Created by Filipi Romão on 16/05/25.
//

import SwiftUI
import SwiftData


struct WorkoutView: View {
    @State var showAddSkill: Bool = false
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State var teste :Int = 0
    @State var modality: Modality
    
    
    var today: Date = Date()
    
    @Binding var registeredWorkouts:[WorkoutData]
    @State var registeredSkills: [String] = []
    var body: some View {
        
        ZStack{
            Color("background").ignoresSafeArea()
            VStack(){
                VStack(alignment: .leading,spacing: 16){
                    HStack{
                        Text("Suas habilidades")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(Color("text"))
                        Spacer()
                        Button(action:{
                            print("Aqui vai add")
                            showAddSkill.toggle()
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .regular))
                                .padding(.trailing,16)
                                .foregroundStyle(Color("text"))
                        }
                    }
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
                    let today = Date()
                    let registeredSkillsToday = modality.datesRegistered.filter {
                        Calendar.current.isDate($0.dateRegister, inSameDayAs: today)
                    }.map { $0.skill.name }

                    
                    for skill in modality.skillsModality where skill.treinou || skill.aplicou {
                        if registeredSkillsToday.contains(skill.name) {
                            continue
                        }

                        let workout = WorkoutData(skill: skill)
                        workout.treinou = skill.treinou
                        workout.aplicou = skill.aplicou

                        modelContext.insert(workout)
                        modality.datesRegistered.append(workout)
                    }

                    
                    if !modality.trainedToday {
                        modality.totalDaysTrained += 1
                    }
                    
                    modality.trainedToday = true
                    modality.lastTrainedDate = today
                    modality.updateProgress()
                    
                    try? modelContext.save()
                    dismiss()
                })
                {
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
        .onAppear{
            registeredSkills = registeredWorkouts.map({$0.skill.name})
        }
        .sheet(isPresented: $showAddSkill) {
            SheetAddSkillView(modality: $modality)
        }
    }
    
}


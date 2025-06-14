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
    @State private var sendWorkoutPage: Bool = false
    @Environment(\.modelContext) private var modelContext
    
    @State var modality: Modality
    @Binding var registeredWorkouts:[WorkoutData]
    
    let calendar = Calendar.current
    @State private var timer: Timer?

    
    var body: some View {
        NavigationStack{
            ZStack {
                
                Color("background").ignoresSafeArea()
                VStack{
                    VStack(alignment: .leading){
                        MenuMyModalities(modalitySelected: $modality)
                        Text("Seu progresso nos treinos")
                            .foregroundColor(Color("text"))
                            .font(.system(size: 26, weight: .bold))
                        TextViewDaysTrained(modality: $modality)

                            
                    }.frame(maxWidth: 346, alignment: .leading)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    Spacer()
                    ViewProgress(modalityProgress: $modality.goalProgress,modality:$modality)
                    Spacer()
                    CalendarView(selectedDate: $currentDate, registeredDates: modality.datesRegistered.map { $0.dateRegister }, registeredWorkouts: modality.datesRegistered)
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
                        .padding(.bottom, 20)
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $sendWorkoutPage) {
                WorkoutView(modality:modality, registeredWorkouts: $registeredWorkouts)
                
            }
        }
        .onChange(of:modality.nameModality){
            modality.updateProgress()
            registeredWorkouts = modality.datesRegistered.filter {
                    Calendar.current.isDate($0.dateRegister, inSameDayAs: Date())
                }
        }
        .onAppear {
            Modality.resetDailyIfNeeded(context: modelContext)
        }


    }
    
}
extension UserDefaults {
    static let lastResetDateKey = "lastResetDate"
}

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
    
    let calendar = Calendar.current
    @State private var timer: Timer?
//    @State var currentDay = Calendar.current.startOfDay(for: Date())
//    
//    func checkAndResetTasksIfNeeded() {
//            let lastReset = UserDefaults.standard.object(forKey: UserDefaults.lastResetDateKey) as? Date
//            let lastResetDay = lastReset.map { calendar.startOfDay(for: $0) }
//
//            guard lastResetDay != currentDay else {
//                return // Já ressetou hoje
//            }
//
////             Fetch modality do banco
//            let descriptor = FetchDescriptor<Modality>()
//            do {
//                let modalities = try modelContext.fetch(descriptor)
//
//                for modality in modalities {
//                        modality.completed = false // Reseta a conclusão
//                }
//
//                try modelContext.save()
//                UserDefaults.standard.set(Date(), forKey: UserDefaults.lastResetDateKey)
//            } catch {
//                print("Erro ao resetar tarefas diárias: (error.localizedDescription)")
//            }
//        
//        }

    
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
                        .padding(.bottom, 20)
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $sendWorkoutPage) {
                WorkoutView(modality:modality)
            }
        }
        .onChange(of:modality.nameModality){
            modality.updateProgress()
        }
        .onAppear {
            UserDefaults.standard.set(
                        Calendar.current.date(byAdding: .day, value: -1, to: Date()),
                        forKey: UserDefaults.lastResetDateKey
                    )
            Modality.resetDailyIfNeeded(context: modelContext)
        }


    }
    
}
extension UserDefaults {
    static let lastResetDateKey = "lastResetDate"
}

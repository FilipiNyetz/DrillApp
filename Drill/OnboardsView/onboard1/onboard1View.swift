
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
    @State private var modality = Modality(nameModality: "Jiu-Jitsu", belt: "Branca", graduation: "Lisa", skillsModality: [],datesRegistered: [])
    
    @State private var nextPage: Bool = false
    
    @State private var annualGoalText: String = ""
    var camposInvalidos: Bool {
        !isValidGoalDays(annualGoalText)
    }
    
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color("background").ignoresSafeArea().foregroundColor(.white)
                VStack{
                    HStack {
                        headerOnboard1()
                        Spacer()
                    }.padding(.top,24)
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
                                EmptyView()
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
                            nextPage = true
                            modality.goalDays = Int(annualGoalText) ?? 00
                            modelContext.insert(modality)
                            
                            try! modelContext.save()
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
                    .navigationDestination(isPresented: $nextPage) {
                        Onboard2(modality: modality)
                    }
                }
                
            }.tint(.white)
                .onChange(of: modality.nameModality) { oldValue, newValue in
                    modality.belt = "Branca"
                    modality.graduation = "Lisa"
                    
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
                    checkForPermision()
                }
           
            
        }
        
    }
    func isValidGoalDays(_ text: String) -> Bool {
        guard let value = Int(text), value >= 1 else {
            return false
        }
        return true
    }
   
    func checkForPermision(){
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                print("Permissão autorizada")
                self.dispatchNotification()
            case .denied:
                print("Permissão negada")
                return
            case .notDetermined:
                print("Permissão ainda não foi demandada")
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow,error in
                    if didAllow{
                        self.dispatchNotification()
                    }
                }
            default:
                print("Algum problema inesperado")
                return
            }
        }
    }
    func dispatchNotification() {
        let title = "Hora de lutar pelo seu progresso!"
        let body = "Treine hoje. Supere ontem. Continue evoluindo!"
        let hour = 20
        let minute = 0
        let isDaily = true
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        
        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: "LocalNotification", content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: ["LocalNotification"])
        notificationCenter.add(request)
        
    }
}

import SwiftUI
import SwiftData

struct TabViewComponent: View {
    
    @Query private var modalities: [Modality]
    @State private var modality: Modality?
    
    @Query private var registeredDates: [WorkoutData]
    @State private var allRegisteredDates: [WorkoutData] = []
    
    var body: some View {
        Group {
            if let modality = modalities.first {
                TabView {
                    homeView(modality: modality,registeredWorkouts: $allRegisteredDates)
                        .tabItem {
                            Image(systemName: "house")
                            Text("Início")
                        }.toolbarBackground(Color("darkGray"), for: .tabBar)
                        .toolbarBackground(.visible, for: .tabBar)
                        .toolbarColorScheme(.dark, for: .tabBar)
                    
                    RankingView()
                        .tabItem {
                            Image(systemName: "star.fill")
                            Text("Classificação")
                        }.toolbarBackground(Color("darkGray"), for: .tabBar)
                        .toolbarBackground(.visible, for: .tabBar)
                        .toolbarColorScheme(.dark, for: .tabBar)
                    
                    ProfileView(modality: modality)
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("Perfil")
                        }.toolbarBackground(Color("darkGray"), for: .tabBar)
                        .toolbarBackground(.visible, for: .tabBar)
                        .toolbarColorScheme(.dark, for: .tabBar)
                }
                
            } else {
                Text("Carregando dados...")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            allRegisteredDates = registeredDates
        }
        
    }
}

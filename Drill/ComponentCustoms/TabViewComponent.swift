import SwiftUI
import SwiftData

struct TabViewComponent: View {
    
    @Query private var modalities: [Modality]
    
    var body: some View {
        
        if let modality = modalities.first {
            TabView {
                
                Group {
                    homeView(modality: modality)
                        .tabItem {
                            Image(systemName: "house")
                            Text("Início")
                        }
                    RankingView()
                        .tabItem {
                            Image(systemName: "star.fill")
                            Text("Classificação")
                        }
                    ProfileView(modality: modality)
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("Perfil")
                        }
                }
                .toolbarBackground(Color("darkGray"), for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.dark, for: .tabBar)
            }
        } else {
            // Exibe algo enquanto a modality ainda não foi criada (ex: onboarding)
            Text("Carregando dados...")
        }
    }
}

#Preview {
    TabViewComponent()
}


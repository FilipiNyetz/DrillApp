import SwiftUI
import SwiftData

@main
struct DrillApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            
            Modality.self,
            SkillProgress.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @AppStorage("visualizouOnboarding") var visualizouOnboarding: Bool = false
    
    @Query private var modalities: [Modality]
    @State private var modality: Modality?
    
    var body: some Scene {
        WindowGroup {
            if visualizouOnboarding {
                TabViewComponent()
            } else {
                onboard1View()
            }
        }
        .modelContainer(sharedModelContainer)
        
    }
}

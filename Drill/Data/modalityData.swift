import Foundation
import SwiftData

@Model
final class Modality {
    var nameModality: String
    var belt: String
    var graduation: String
    var totalDaysTrained: Int
    var skillsModality: [SkillProgress] = []
    var trainedToday: Bool
    var goalDays: Int
    var goalProgress: Double
    var lastTrainedDate: Date?

    init(
        nameModality: String = "",
        belt: String = "",
        graduation: String = "",
        totalDaysTrained: Int = 0,
        skillsModality: [SkillProgress],
        trainedToday: Bool = false,
        goalDays: Int = 0,
        goalProgress: Double = 0,
        lastTrainedDate: Date? = nil
    ) {
        self.nameModality = nameModality
        self.belt = belt
        self.graduation = graduation
        self.totalDaysTrained = totalDaysTrained
        self.skillsModality = skillsModality
        self.trainedToday = trainedToday
        self.goalDays = goalDays
        self.goalProgress = goalProgress
        self.lastTrainedDate = lastTrainedDate
    }

    func updateProgress() {
        guard goalDays > 0 else {
            goalProgress = 0
            return
        }
        goalProgress = Double(totalDaysTrained) / Double(goalDays)
    }

    static func resetDailyIfNeeded(context: ModelContext) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        let lastReset = UserDefaults.standard.object(forKey: UserDefaults.lastResetDateKey) as? Date
        let lastResetDay = lastReset.map { calendar.startOfDay(for: $0) }

        guard lastResetDay != today else {
            return // Já foi resetado hoje
        }

        let descriptor = FetchDescriptor<Modality>()
        do {
            let modalities = try context.fetch(descriptor)

            for modality in modalities {
                modality.trainedToday = false
                modality.lastTrainedDate = nil
                for skill in modality.skillsModality {
                    skill.treinou = false
                    skill.aplicou = false
                }
            }

            try context.save()
            UserDefaults.standard.set(Date(), forKey: UserDefaults.lastResetDateKey)
            print("✅ Reset diário executado.")
        } catch {
            print("Erro ao resetar tarefas diárias: \(error.localizedDescription)")
        }
    }
}

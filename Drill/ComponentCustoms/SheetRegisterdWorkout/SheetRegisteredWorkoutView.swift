import SwiftUI

struct SheetRegisteredWorkoutView: View {
    @State var workoutsRegisteredInDay: [WorkoutData]
    
    var body: some View {
        ZStack {
            Color(.black).ignoresSafeArea()
            VStack(spacing: 16) {
                if let date = workoutsRegisteredInDay.first?.dateRegister {
                    Text("\(formattedDate(date))")
                        .font(.system(size: 16,weight: .semibold))
                        .foregroundColor(Color("text"))
                } else {
                    Text("Nenhum treino neste dia")
                        .font(.subheadline)
                }

                Text("Seu treino")
                    .font(.system(size: 28,weight: .bold))
                    .foregroundColor(Color("text"))

                ForEach(workoutsRegisteredInDay, id: \.self) { workout in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("\(workout.skill.name)")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Color("text"))
                            Spacer()
                            ProgressRegisteredWorkout(porcentagemSkill: workout.skill.progress)
                        }

                        HStack(spacing: 12) {
                            if workout.treinou {
                                HStack {
                                    Image(systemName:"flame.fill")
                                        .foregroundColor(.red)
                                    Text("Treinou")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("text"))
                                }
                            }

                            if workout.aplicou {
                                HStack {
                                    Image(systemName:"flame.fill")
                                        .foregroundColor(.red)
                                    Text("Aplicou")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("text"))
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color("background"))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }


                Spacer()
            }
            .padding()
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateStyle = .full
        return formatter.string(from: date)
    }
}

import SwiftUI

struct CustomCalendarView: View {
    @State private var selectedDate: Date = Date()
    @State private var today: Date = Date.now
    @State private var monthOffset: Int = 0

    private let calendar = Calendar.current
    private let daysOfWeek = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab"]

    var workoutDates: [Date] // ← Datas com treino (ex: modality.datesRegistered.map { $0.dateRegister })

    private var currentMonth: Date {
        calendar.date(byAdding: .month, value: monthOffset, to: Date()) ?? Date()
    }

    private var daysInMonth: [Date] {
        guard let range = calendar.range(of: .day, in: .month, for: currentMonth),
              let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth)) else {
            return []
        }

        let weekday = calendar.component(.weekday, from: firstDay)
        let adjustedWeekday = (weekday - calendar.firstWeekday + 7) % 7
        let prefixDays = Array(repeating: Date.distantPast, count: adjustedWeekday)

        return prefixDays + range.compactMap { day in
            calendar.date(byAdding: .day, value: day - 1, to: firstDay)
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(workoutDates)")
            
            // Cabeçalho com mês e ano
            HStack {
                Text(formattedDate(currentMonth, format: "MMMM yyyy"))
                    .font(.title2.bold())
                    .foregroundColor(Color("text"))

                Spacer()

                HStack(spacing: 24) {
                    Button(action: {
                        monthOffset -= 1
                    }) {
                        Image(systemName: "chevron.left").foregroundColor(Color("text"))
                    }

                    Button(action: {
                        monthOffset += 1
                    }) {
                        Image(systemName: "chevron.right").foregroundColor(Color("text"))
                    }
                }
            }
            .padding(.horizontal)

            // Dias da semana
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 13, weight: .semibold))
                        .frame(maxWidth: 42)
                        .foregroundColor(Color("text"))
                }
            }
            .padding(.top, 2)
            .padding(.leading, 12)

            // Dias do mês
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 12) {
                ForEach(daysInMonth, id: \.self) { date in
                    if calendar.isDate(date, equalTo: Date.distantPast, toGranularity: .day) {
                        Color.clear.frame(height: 36)
                    } else {
                        Button {
                            selectedDate = date
                        } label: {
                            Text("\(calendar.component(.day, from: date))")
                                .font(.system(size: 20))
                                .frame(width: 36, height: 36)
                                .foregroundColor(.white)
                                .background(
                                    ZStack {
                                        if calendar.isDate(date, inSameDayAs: today) {
                                            Circle().fill(Color("darkGray"))
                                        }
                                        if calendar.isDate(date, inSameDayAs: selectedDate) {
                                            Circle().fill(Color("primary"))
                                        }
                                        if workoutDates.contains(where: { calendar.isDate($0, inSameDayAs: date) }) {
                                            
                                            Circle()
                                                .stroke(Color("primary"), lineWidth: 2)
                                                .frame(width: 40, height: 40)
                                        }
                                    }
                                )
                                .clipShape(Circle())
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(width: 354)
        .padding(.vertical)
        .background(Color("secondary"))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        .padding()
    }

    private func formattedDate(_ date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}



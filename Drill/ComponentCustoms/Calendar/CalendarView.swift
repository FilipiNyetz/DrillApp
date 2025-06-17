import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date
    var registeredDates: [Date]
    var registeredWorkouts: [WorkoutData]
    
    @Environment(\.calendar) private var calendar
    @Environment(\.locale) private var locale  // pega a localidade do ambiente
    
    @State private var showDatePicker = false

    private var currentMonth: Date {
        calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate)) ?? selectedDate
    }

    private var monthYearString: String {
        let formatter = DateFormatter()
        formatter.locale = locale             // usa localidade do usuário
        formatter.dateFormat = "MMMM yyyy"   // mes + ano
        return formatter.string(from: currentMonth).capitalized
    }

    private var daysInMonth: [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: currentMonth),
              let firstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
              let lastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1) else {
            return []
        }

        let fullRange = DateInterval(start: firstWeek.start, end: lastWeek.end)
        return stride(from: fullRange.start, to: fullRange.end, by: 60 * 60 * 24).map { $0 }
    }
    
    // Gera abreviações dos dias da semana conforme localidade do usuário, começando no primeiro dia da semana do calendário atual
    private var weekDays: [String] {
        let formatter = DateFormatter()
        formatter.locale = locale
        // formato abreviado (ex: Dom, Seg, Ter em pt_BR; Sun, Mon, Tue em en_US)
        let symbols = formatter.shortStandaloneWeekdaySymbols ?? []
        
        // O Calendar tem o primeiro dia da semana (ex: 1 = domingo no US, 2 = segunda na maioria dos países)
        let firstWeekdayIndex = calendar.firstWeekday - 1  // ajustar para índice 0-based
        
        // Reordena os dias para começar pelo dia da semana correto
        return (0..<7).map { index in
            let i = (index + firstWeekdayIndex) % 7
            return symbols[i].uppercased() + "." // seu estilo com ponto
        }
    }

    var body: some View {
        VStack(spacing: 16) {
            CalendarHeaderView(
                monthYearString: monthYearString,
                onPrevious: { changeMonth(by: -1) },
                onNext: { changeMonth(by: 1) }
            )

            CalendarWeekdaysView(weekDays: weekDays)

            CalendarDaysGrid(
                selectedDate: $selectedDate,
                currentMonth: currentMonth,
                daysInMonth: daysInMonth,
                registeredDates: registeredDates,
                registeredWorkout: registeredWorkouts
            )
        }
        .padding(.vertical, 12)
        .padding(.top, 8)
        .background(Color("secondary"))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .padding(.horizontal, 24)
    }

    private func changeMonth(by value: Int) {
        if let newMonth = calendar.date(byAdding: .month, value: value, to: currentMonth) {
            selectedDate = newMonth
        }
    }
}

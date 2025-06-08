import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date
     var registeredDates: [Date]
    
    @Environment(\.calendar) private var calendar
    @State private var showDatePicker = false

    private var currentMonth: Date {
        calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate)) ?? selectedDate
    }

    private var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM 'de' yyyy"
        formatter.locale = Locale(identifier: "pt_BR")
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

    private let weekDays = ["DOM.", "SEG.", "TER.", "QUA.", "QUI.", "SEX.", "SÁB."]

    var body: some View {
        VStack(spacing: 16) {
            CalendarHeaderView(monthYearString: monthYearString, onPrevious: { changeMonth(by: -1) }, onNext: { changeMonth(by: 1) })

            CalendarWeekdaysView(weekDays: weekDays)

            CalendarDaysGrid(
                selectedDate: $selectedDate,
                currentMonth: currentMonth,
                daysInMonth: daysInMonth,
                registeredDates: registeredDates
            )
        }
        .padding(.vertical, 16)
        .padding(.top, 12)
        .background(Color(.systemGray6).opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .padding(.horizontal, 8)
    }

    private func changeMonth(by value: Int) {
        if let newMonth = calendar.date(byAdding: .month, value: value, to: currentMonth) {
            selectedDate = newMonth
        }
    }
}

import SwiftUI

struct CalendarDaysGrid: View {
    @Environment(\.calendar) private var calendar

    @Binding var selectedDate: Date
    let currentMonth: Date
    let daysInMonth: [Date]
    let registeredDates: [Date]

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
            ForEach(daysInMonth, id: \.self) { date in
                let day = calendar.component(.day, from: date)
                let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)
                let isToday = calendar.isDateInToday(date)
                let isFuture = date > Date()
                let hasRecord = registeredDates.contains(where: { calendar.isDate($0, inSameDayAs: date) })

                if calendar.isDate(date, equalTo: currentMonth, toGranularity: .month) {
                    Button {
                        if !isFuture {
                            selectedDate = date
                        }
                    } label: {
                        Text("\(day)")
                            .font(.callout)
                            .fontWeight(.medium)
                            .frame(width: 32, height: 32)
                            .foregroundColor(isFuture ? .gray : (isSelected ? .white : .white))
                            .background(isSelected ? Color("primary") : Color.clear)
                            .clipShape(Circle())
                            .overlay(
                                Group {
                                    if hasRecord {
                                        Circle()
                                            .fill(isSelected ? .white : Color("primary"))
                                            .frame(width: 6, height: 6)
                                            .offset(y: 10)
                                    }
                                }
                            )
                    }
                    .disabled(isFuture)
                } else {
                    Text("")
                        .frame(width: 32, height: 32)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 8)
    }
}

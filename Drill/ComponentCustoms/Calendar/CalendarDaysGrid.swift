import SwiftUI

struct CalendarDaysGrid: View {
    @Environment(\.calendar) private var calendar

    @Binding var selectedDate: Date
    let currentMonth: Date
    let daysInMonth: [Date]
    let registeredDates: [Date]
    let registeredWorkout: [WorkoutData]
    
    @State var showWorkoutSheet: Bool = false

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 6) {
            ForEach(daysInMonth, id: \.self) { date in
                let day = calendar.component(.day, from: date)
                let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)
//                let isToday = calendar.isDateInToday(date)
                let isFuture = date > Date()
                let hasRecord = registeredDates.contains(where: { calendar.isDate($0, inSameDayAs: date) })
                
                let workoutsForDay = registeredWorkout.filter {
                    calendar.isDate($0.dateRegister, inSameDayAs: date)
                }


                if calendar.isDate(date, equalTo: currentMonth, toGranularity: .month) {
                    Button{
                       
                        print("\(workoutsForDay.map{$0.skill.name})")
                        if !isFuture {
                            selectedDate = date
                        }
                        if hasRecord{
                            showWorkoutSheet.toggle()
                        }
                    } label: {
                        Text("\(day)")
                            .font(.system(size: 16, weight: .regular))
                            .frame(width: 24, height: 24)
                            .foregroundColor(isFuture ? .gray : (isSelected ? .white : .white))
                            .background(isSelected ? Color("primary") : Color.clear)
                            .clipShape(Circle())
                            .overlay(
                                Group {
                                    if hasRecord {
                                        Circle()
                                            .fill(isSelected ? .white : Color("primary"))
                                            .frame(width: 4, height: 4)
                                            .offset(y: 8)
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
        .sheet(isPresented: $showWorkoutSheet) {
            SheetRegisteredWorkoutView()
        }
    }
       
}

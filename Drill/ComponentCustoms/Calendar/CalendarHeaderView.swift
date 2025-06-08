import SwiftUI

struct CalendarHeaderView: View {
    let monthYearString: String
    var onPrevious: () -> Void
    var onNext: () -> Void

    var body: some View {
        HStack {
            Text(monthYearString)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()

            HStack(spacing: 16) {
                Button(action: onPrevious) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.body)
                }

                Button(action: onNext) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                        .font(.body)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

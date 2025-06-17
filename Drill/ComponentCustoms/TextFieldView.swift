import SwiftUI
struct TextFieldView: View {
    @Binding var annualGoalText: String
    let characterLimit = 3
    
    var body: some View {
        ZStack(alignment: .leading) {
            if annualGoalText.isEmpty {
                Text("Ex: 150")
                    .foregroundColor(.white.opacity(0.5))
                    .padding(.leading, 20)
            }
            
            TextField("", text: $annualGoalText)
                .foregroundColor(Color("text"))
                .keyboardType(.numberPad)
                .padding(.horizontal, 20)
                .frame(width: 346, height: 44)
                .background(Color("secondary"))
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color("darkGray"), lineWidth: 1)
                )
                .onChange(of: annualGoalText) {
                    if annualGoalText.count > characterLimit {
                        annualGoalText = String(annualGoalText.prefix(characterLimit))
                    }
                }
        }
    }
}

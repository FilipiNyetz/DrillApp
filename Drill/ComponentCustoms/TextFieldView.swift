//
//  TextFieldView.swift
//  Drill
//
//  Created by Filipi Romão on 29/05/25.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var annualGoalText: String
    var body: some View {
        ZStack(alignment: .leading) {
            if annualGoalText.isEmpty {
                Text("Ex: 150")
                    .foregroundColor(.white.opacity(0.5)) // Cor do "placeholder"
                    .padding(.leading, 20) // alinhamento com o TextField interno
            }

            TextField("", text: $annualGoalText)
                .foregroundColor(Color("text")) // Cor do texto digitado
                .keyboardType(.numberPad)
                .padding(.horizontal, 20)
                .frame(width: 346, height: 44)
                .background(Color("secondary"))
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color("darkGray"), lineWidth: 1)
                )
        }
    }
}


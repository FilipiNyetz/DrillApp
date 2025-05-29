//
//  TextViewDaysTrained.swift
//  Drill
//
//  Created by Filipi Romão on 28/05/25.
//

import SwiftUI

struct TextViewDaysTrained: View {
    @Binding var modality:Modality
    var body: some View {
        if modality.totalDaysTrained >= modality.goalDays {
            Text("Parabéns! Você atingiu sua meta!")
                .foregroundColor(Color("text"))
                .font(.system(size: 17, weight: .regular))
        } else if modality.totalDaysTrained == 1 {
            Text("Você já completou 1 treino este ano")
                .foregroundColor(Color("text"))
                .font(.system(size: 17, weight: .regular))
        }else if modality.totalDaysTrained > 1{
            Text("Você já completou \(modality.totalDaysTrained) treinos este ano")
                .foregroundColor(Color("text"))
                .font(.system(size: 17, weight: .regular))
        }else {
            Text("Comece hoje a construir sua jornada")
                .foregroundColor(Color("text"))
                .font(.system(size: 17, weight: .regular))
        }
    }
}



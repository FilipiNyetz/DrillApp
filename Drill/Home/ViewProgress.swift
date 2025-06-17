//
//  ViewProgress.swift
//  Drill
//
//  Created by Filipi Romão on 16/05/25.
//

import SwiftUI

struct ViewProgress: View {
    @Binding var modalityProgress:Double
    @Binding var modality:Modality
    var body: some View {
        VStack(alignment: .leading,spacing: 12){
            VStack(alignment: .leading){
                HStack{
                    if modality.datesRegistered.isEmpty{
                        Text(Image(systemName: "minus"))
                        Text("Estagnado")
                    }else{
                        Text(Image(systemName: "arrow.up"))
                        Text("Progresso")
                    }
                }.font(.system(size: 22,weight: .semibold))
                    .foregroundColor(Color("text"))
                if modality.datesRegistered.isEmpty{
                    Text("Comece a treinar!").font(.system(size: 14,weight: .regular))
                        .foregroundColor(Color("text")).padding(.leading,4)
                }else {
                    Text("Você está em ascensão!").font(.system(size: 14,weight: .regular))
                        .foregroundColor(Color("text")).padding(.leading,4)
                }
                
            }.padding(.top,12)
           
            ProgressBarCustom(progress: $modalityProgress)
            
            
        }.frame(width: 322, height: 96)
            .background(Color("secondary"))
            .cornerRadius(8)
        
        
    }
}



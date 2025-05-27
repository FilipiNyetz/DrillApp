//
//  ViewProgress.swift
//  Drill
//
//  Created by Filipi Romão on 16/05/25.
//

import SwiftUI

struct ViewProgress: View {
    
    var body: some View {
        VStack(alignment: .leading,spacing: 12){
            VStack(alignment: .leading){
                HStack{
                    Text(Image(systemName: "arrow.up"))
                    Text("Progresso")
                }.font(.system(size: 22,weight: .semibold))
                    .foregroundColor(Color("text"))
                Text("Você está em ascensão").font(.system(size: 14,weight: .regular))
                    .foregroundColor(Color("text")).padding(.leading,4)
            }.padding(.top,12)
           
            
            ProgressBarCustom()
        }.frame(width: 322, height: 96)
            .background(Color("secondary"))
            .cornerRadius(8)
        
        
    }
}



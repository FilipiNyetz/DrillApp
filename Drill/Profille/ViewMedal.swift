//
//  ViewMedal.swift
//  Drill
//
//  Created by Filipi Romão on 25/05/25.
//

import SwiftUI

struct ViewMedal: View {
    var nomeSkill: String
    var porcentagemSkill: Double
    var medalha: String
    var body: some View {
        HStack(spacing: 20){
            Image(medalha)
            VStack(alignment: .leading, spacing: 6){
                Text("\(nomeSkill)").font(.system(size: 18, weight: .bold))
                Text("Domínio:\(Int(porcentagemSkill))%").font(.system(size: 14,weight: .regular))
            }.foregroundStyle(.text)
        }.frame(width: 168, height: 68)
            .background(Color("secondary"))
            .border(Color("darkGray"), width: 1)
        
    }
}



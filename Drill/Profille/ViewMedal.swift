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
    @State private var showDescribeMedal = false
    var body: some View {
        Button(action:{
            showDescribeMedal.toggle()
        }){
            HStack(spacing: 20){
                Image(medalha)
                    .resizable()
                    .frame(width: 27, height: 40)
                VStack(alignment: .leading, spacing: 6){
                    Text("\(nomeSkill)").font(.system(size: 18, weight: .bold))
                    Text("Domínio:\(Int(porcentagemSkill))%").font(.system(size: 14,weight: .regular))
                }.foregroundStyle(.text)
            }.frame(width: 168, height: 68)
                .background(Color("secondary"))
                .border(Color("darkGray"), width: 1)
        }.sheet(isPresented: $showDescribeMedal){
            ModalMedal(nomeSkill:nomeSkill, porcentagemSkill:porcentagemSkill, medalha:medalha)
                .presentationDetents([.medium])
        }
        
    }
}



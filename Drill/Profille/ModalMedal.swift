//
//  ModalMedal.swift
//  Drill
//
//  Created by Filipi Romão on 28/05/25.
//

import SwiftUI

struct ModalMedal: View {
    @State var nomeSkill: String
    @State var porcentagemSkill: Double
    @State var medalha: String
    var body: some View {
        ZStack{
            Color("background").opacity(0.90).ignoresSafeArea()
            VStack{
                Image(medalha)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 80)
                VStack(spacing: 4){
                    Text("\(nomeSkill)")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color("text"))
                    Text("Domínio: \(Int(porcentagemSkill))%")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundStyle(Color("text"))
                }
                ProgressBarMedal(porcentagemSkill: porcentagemSkill)
                VStack(alignment: .leading, spacing: 8){
                    if(porcentagemSkill<100.0){
                        Text("Parabéns! você está evoluindo o \(nomeSkill)")
                        Text("Continue treinando para alcançar o próximo nível!")
                    }else{
                        Text("Parabéns! você dominou completamente o \(nomeSkill)")
                        Text("Continue treinando para manter a excelência !")
                    }
                }.font(.system(size: 16, weight: .regular))
                .foregroundStyle(Color("text"))
            }
            
        }
        
    }
}


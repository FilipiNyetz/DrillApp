//
//  HeaderOnboard2.swift
//  Drill
//
//  Created by Filipi Romão on 30/05/25.
//

import SwiftUI

struct HeaderOnboard2: View {
    @State var modality:Modality
    @State var showAddSkill: Bool = false
    var body: some View {
        VStack{
            Text("\(modality.nameModality)")
                .font(.system(size: 24,weight: .semibold))
            VStack(alignment:.leading,spacing: 8){
                Text("2/2").foregroundColor(Color("primary"))
                    .font(.system(.body, weight: .bold))
                HStack{
                    Text("Suas habilidades")
                        .foregroundColor(Color("text"))
                        .font(.system(.title, weight: .bold))
                    Spacer()
                    Button(action:{
                        print("add bt")
                        showAddSkill.toggle()
                    }){
                        Image(systemName: "plus")
                            .font(.system(size: 24, weight: .regular))
                            .padding(.trailing,16)
                            .foregroundStyle(Color("text"))
                    }
                }
                Text("Defina suas porcentagens de progresso")
                    .foregroundColor(Color("text"))
            }.frame(maxWidth: 346, alignment: .leading)
        }
        .sheet(isPresented: $showAddSkill) {
            SheetAddSkillView(modality: $modality)
        }
    }
}



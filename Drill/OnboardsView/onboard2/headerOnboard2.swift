//
//  headerOnboard2.swift
//  Drill
//
//  Created by Filipi Romão on 16/05/25.
//

import SwiftUI

struct headerOnboard2: View {
    var body: some View {
        VStack(alignment:.leading,spacing: 8){
            Text("2/2").foregroundColor(Color("primary"))
                .font(.system(.body, weight: .bold))
            Text("Avalie suas habilidades")
                .foregroundColor(Color("text"))
                .font(.system(.title, weight: .bold))
            Text("Defina suas porcentagens de progresso")
                .foregroundColor(Color("text"))
        }.frame(maxWidth: 346, alignment: .leading)    }
}



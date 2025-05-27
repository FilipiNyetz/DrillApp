//
//  headerOnboard1.swift
//  Drill
//
//  Created by Filipi Romão on 19/05/25.
//

import SwiftUI

struct headerOnboard1: View {
    var body: some View {
        VStack(alignment:.leading,spacing: 8){
            Text("1/2").foregroundColor(Color("primary"))
                .font(.system(.body, weight: .bold))
            Text("Personalize seu APP")
                .foregroundColor(Color("text"))
                .font(.system(.title, weight: .bold))
        }
        .padding(.leading,26)    }
}

#Preview {
    headerOnboard1()
}

//
//  CelulaPersonalizar.swift
//  Drill
//
//  Created by Filipi Romão on 14/05/25.
//

import SwiftUI
import SwiftData

struct CelulaPersonalizar: View {
    var options: [String]
    var context : String
    @Binding var element: String
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        VStack(alignment: .leading){
            Text("Informe sua modalidade").foregroundColor(Color("text")).font(.system(.title2, weight: .semibold))
            HStack(){
                Text("\(context)")
                    .foregroundColor(Color("text"))
                Spacer()
                Menu{
                    ForEach(options, id: \.self) { item in
                        Button(action:{
                            element = item
                            try? modelContext.save()
                        }){
                            Text(item)
                        }
                    }
                }label:{
                    HStack{
                        Text(element)
                        (Image(systemName: "chevron.up.chevron.down"))
                    }
                }.foregroundColor(Color("text"))
                
                
            }.padding(.trailing,20)
                .padding(.leading,20)
                .frame(width: 346, height: 44)
                .border(Color("darkGray"))
                .background(Color("secondary"))
            
        }
    }
}


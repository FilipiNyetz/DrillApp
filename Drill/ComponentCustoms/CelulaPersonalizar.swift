import SwiftUI
import SwiftData

struct CelulaPersonalizar: View {
    var options: [String]
    var context: String
    @Binding var element: String
    @Environment(\.modelContext) private var modelContext
    @Environment(\.locale) var locale  

    var body: some View {
        VStack(alignment: .leading) {
            Text(String(
                format: NSLocalizedString("Informe sua %@", comment: "Prompt for selecting a value"),
                NSLocalizedString(context, comment: "Context label")
            ))
            .foregroundColor(Color("text"))
            .font(.system(size: 18, weight: .semibold))

            HStack {
                Text(NSLocalizedString(context, comment: "Context label"))
                    .foregroundColor(Color("text"))
                
                Spacer()
                
                Menu {
                    ForEach(options, id: \.self) { item in
                        Button(action: {
                            element = item  // salva o valor original em português
                            try? modelContext.save()
                        }) {
                            Text(NSLocalizedString(item, comment: "\(context) option"))
                        }
                    }
                } label: {
                    HStack {
                        Text(NSLocalizedString(element, comment: "\(context) selected value"))
                        Image(systemName: "chevron.up.chevron.down")
                    }
                }
                .foregroundColor(Color("text"))
            }
            .padding(.horizontal, 20)
            .frame(width: 346, height: 44)
            .border(Color("darkGray"))
            .background(Color("secondary"))
        }
    
        .id(locale.identifier)
    }
}

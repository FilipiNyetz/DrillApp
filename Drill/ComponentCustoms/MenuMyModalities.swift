import SwiftUI
import SwiftData

struct MenuMyModalities: View {
    @Query var modalities: [Modality]
    @Binding var modalitySelected: Modality

    var body: some View {
        
        VStack(alignment: .leading){
            Text("Selecione sua modalidade").foregroundColor(Color("text")).font(.system(size: 18, weight: .semibold))
            HStack(){
                Text("Suas modalidades")
                    .foregroundColor(Color("text"))
                Spacer()
                Menu{
                    ForEach(modalities, id: \.self) { myModality in
                        Button(action: {
                            modalitySelected = myModality
                        }) {
                            Text(myModality.nameModality)
                        }
                    }
                }label:{
                    HStack{
                        Text("\(modalitySelected.nameModality)")
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

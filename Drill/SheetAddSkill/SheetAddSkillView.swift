import SwiftUI
import SwiftData

struct SheetAddSkillView: View {
    @Binding var modality: Modality
    @State private var nameNovaSkill: String = ""
    @State private var newSkills: [SkillProgress] = []

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        ZStack {
            Color("background").ignoresSafeArea()

            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 24) {
                        Text("Adicionar nova habilidade")
                            .font(.headline)
                            .foregroundColor(Color("text"))
                            .frame(maxWidth: .infinity, alignment: .leading)

                        TextField("Digite o nome da nova habilidade", text: $nameNovaSkill)
                            .foregroundColor(Color("text"))
                            .padding(.horizontal, 20)
                            .frame(height: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("darkGray"), lineWidth: 1)
                            )
                            .focused($isTextFieldFocused)

                        Button(action: {
                            adicionarSkill(name: nameNovaSkill)
                            nameNovaSkill = ""
                            isTextFieldFocused = false
                        }) {
                            Text("Adicionar habilidade")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(nameNovaSkill.isEmpty ? Color.gray : Color("primary"))
                                .cornerRadius(12)
                        }
                        .disabled(nameNovaSkill.isEmpty)

                        Divider()

                        if !newSkills.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                ForEach($newSkills, id: \.self) { $skill in
                                    sliderSkill(skillValue: $skill.progress, name: skill.name)
                                }
                            }
                            .padding()
                            .background(Color("secondary").cornerRadius(16))
                        }
                    }
                    .padding()
                }

                VStack {
                    Divider().padding(.horizontal)

                    Button(action: {
                        modality.skillsModality.append(contentsOf: newSkills)
                        for skill in modality.skillsModality{
                            skill.updateMedal(progress: skill.progress)
                        }
                        modelContext.insert(modality)
                        try? modelContext.save()
                        dismiss()
                    }) {
                        Text("Salvar habilidades")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(newSkills.isEmpty ? Color.gray : Color("primary"))
                            .cornerRadius(12)
                    }
                    .disabled(newSkills.isEmpty)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                    .background(Color("background"))
                }
            }
        }

    }

    func adicionarSkill(name: String) {
        if modality.skillsModality.contains(where: { $0.name.lowercased() == name.lowercased() }) {
            return
        }
        let novaSkill = SkillProgress(name: name, progress: 0.0, medal: "nenhuma")
        newSkills.append(novaSkill)
    }
}



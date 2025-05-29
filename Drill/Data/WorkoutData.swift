//
//  WorkoutData.swift
//  Drill
//
//  Created by Filipi Romão on 29/05/25.
//

import Foundation
import SwiftData

@Model
class WorkoutData {
    var dateRegister: Date
    var skill: SkillProgress
    var treinou: Bool   // <- novo
    var aplicou: Bool   // <- novo

    init(skill: SkillProgress) {
        self.dateRegister = Date()
        self.skill = skill
        self.treinou = skill.treinou  // <- salva o estado do momento
        self.aplicou = skill.aplicou  // <- idem
    }
}

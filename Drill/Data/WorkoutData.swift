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
    var treinou: Bool
    var aplicou: Bool

    init(skill: SkillProgress) {
        self.dateRegister = Date()
        self.skill = skill
        self.treinou = skill.treinou
        self.aplicou = skill.aplicou  
    }
}

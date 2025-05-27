//
//  UserData.swift
//  Drill
//
//  Created by Filipi Romão on 19/05/25.
//

import Foundation
import SwiftData

@Model
final class Modality {
    var nameModality: String
    var belt: String
    var graduation: String
    var totalDaysTrained: Int
    var skillsModality: [SkillProgress] = []
    
    
    init(nameModality: String = "", belt: String = "", graduation: String = "", totalDaysTrained: Int = 0, skillsModality: [SkillProgress]) {
        self.nameModality = nameModality
        self.belt = belt
        self.graduation = graduation
        self.totalDaysTrained = 0
        self.skillsModality = skillsModality
    }
}

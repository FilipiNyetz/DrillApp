//
//  SkillProgress.swift
//  Drill
//
//  Created by Filipi Romão on 19/05/25.
//

import Foundation
import SwiftData

@Model
class SkillProgress {
    var name: String
    var progress: Double
    var treinou: Bool
    var aplicou: Bool
    var medal: String
    
    
  

    init(name: String, progress: Double, treinou: Bool = false, aplicou: Bool = false, medal: String, ){
        self.name = name
        self.progress = progress
        self.treinou = treinou
        self.aplicou = aplicou
        self.medal = medal
        
        
    }

    func updateMedal(progress: Double) {
        switch progress {
        case 0..<25: medal = "nenhuma"
        case 25..<50: medal = "medalha25"
        case 50..<75: medal = "medalha50"
        case 75..<100: medal = "medalha75"
        case 100: medal = "medalha100"
        default: medal = "nenhuma"
        }
    }
    
}



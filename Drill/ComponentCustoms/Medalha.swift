//
//  Medalha.swift
//  Drill
//
//  Created by Filipi Romão on 25/05/25.
//


enum Medalha: String {
    case nenhum = "nenhum"
    case medalha25 = "medalha25"
    case medalha50 = "medalha50"
    case medalha75 = "medalha75"
    case medalha100 = "medalha100"
    
    static func fromProgress(_ progress: Double) -> Medalha {
        switch progress {
        case ..<24: return .nenhum
        case ..<50: return .medalha25
        case ..<75: return .medalha50
        case ..<100: return .medalha75
        default: return .medalha100
        }
    }
}

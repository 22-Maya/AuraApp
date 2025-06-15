//
//  Scorer.swift
//  Aura
//
//  Created by Student on 6/10/25.
//

import Foundation
import NaturalLanguage

class Scorer {
    static let shared = Scorer()
    private let tagger = NLTagger(tagSchemes: [.sentimentScore])
    
    func score(_ text: String) -> Double {
        var sentimentScore = 0.0
        tagger.string = text
        tagger.enumerateTags(
            in: text.startIndex..<text.endIndex,
            unit: .paragraph,
            scheme: .sentimentScore,
            options: []
        ) { sentimentTag, _ in
            if let sentimentString = sentimentTag?.rawValue {
                sentimentScore = Double(sentimentString) ?? 0.0
                return true
            }
            return false
        }
        return sentimentScore
    }
    
    func sentimentCategory(for score: Double) -> String {
        let clampedScore = max(-1.0, min(1.0, score.isFinite ? score : 0.0))
        switch clampedScore {
        case ..<(-0.5):
            return "Negative 😞"
        case -0.5..<0.5:
            return "Neutral 😐"
        default:
            return "Positive 😊"
        }
    }

}

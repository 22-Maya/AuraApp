//
//  Scorer.swift
//  Aura
//
//  Created by Student on 6/10/25.
//

import Foundation
import NaturalLanguage


class Scorer {
    let tagger = NLTagger(tagSchemes: [.sentimentScore])


    func score(_ text: String) -> Double {
        
        guard !text.isEmpty
        else {
            return 0
        }
        
        var sentimentScore = 0.0
        tagger.string = text
        tagger.enumerateTags(
            in: text.startIndex..<text.endIndex,
            unit: .paragraph,
            scheme: .sentimentScore,
            options: []) { sentimentTag, _ in
                if let sentimentString = sentimentTag?.rawValue,
                   let score = Double(sentimentString) {
                    sentimentScore = score
                    return true
                }


                return false
            }
        return max(-1.0, min(1.0, sentimentScore))
    }
}

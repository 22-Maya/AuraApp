//
//  JournalEntry.swift
//  Aura
//
//  Created by Student on 6/10/25.
//

import Foundation
import SwiftData

@Model
class JournalEntry {
    var id: UUID
    var title: String
    var text: String
    var date: Date
    var sentimentScore: Double
    
    init(title: String, text: String, date: Date, sentimentScore: Double) {
        self.id = UUID()
        self.title = title
        self.text = text
        self.date = date
        self.sentimentScore = sentimentScore
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    var sentiment: String {
        switch sentimentScore {
            case ..<(-0.5): 
                return "Negative 😞"
            case -0.5..<0.5: 
                return "Neutral 😐"
            default:
                return "Positive 😊"
        }
    }
}

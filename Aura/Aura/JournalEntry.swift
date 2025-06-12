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
    var text: String
    var date: Date
    var sentimentScore: Double
    
    init(text: String, date: Date, sentimentScore: Double) {
        self.id = UUID()
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
}

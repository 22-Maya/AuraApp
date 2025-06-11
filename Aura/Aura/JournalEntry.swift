//
//  JournalEntry.swift
//  Aura
//
//  Created by Student on 6/10/25.
//

import Foundation
import SwiftData

@Model

final class JournalEntry {
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

}

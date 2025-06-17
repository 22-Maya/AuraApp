//
//  JournalEntry.swift
//  Aura
//
//  Created by Student on 6/10/25.
//

import Foundation
import SwiftData
import SwiftUI
import Charts

@Model
class JournalEntry {
    var id: UUID
    var title: String = ""
    var text: String = ""
    var date: Date = Date()
    var sentimentScore: Double = 0.0
    
    enum Sentiment: String, Plottable {
        case positive
        case negative
        case neutral
        
        init(_ score: Double) {
            if score > 0.34 {
                self = .positive
            } else if score < -0.34 {
                self = .negative
            } else {
                self = .neutral
            }
        }
        
        var sentimentIcon: String {
            switch self {
                case .negative:
                    return "Negative 😞"
            case .positive:
                    return "Positive 😊"
                default:
                    return "Neutral 😐"
            }
        }
        
        var sentimentColor: Color {
            switch self {
                case .negative:
                    return .red
            case .positive:
                    return .green
                default:
                    return .gray
            }
        }
    }
    
    var sentiment: Sentiment {
        return Sentiment(sentimentScore)
    }
    
    var sentimentIcon: String {
        return sentiment.sentimentIcon
    }
    
    var sentimentColor: Color {
        return sentiment.sentimentColor
    }
    
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
    
}

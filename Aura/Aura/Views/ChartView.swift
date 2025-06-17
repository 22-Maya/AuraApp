//
//  ChartView.swift
//  Aura
//
//  Created by Student on 6/16/25.
//

import SwiftUI
import Charts

struct ChartView: View {
    let entries: [JournalEntry]
        
    init(entries: [JournalEntry]) {
        self.entries = entries
    }
    
    var body: some View {
        Chart(entries) { entry in
            SectorMark(angle: .value("Type", 1))
                .foregroundStyle(by: .value("sentiment", entry.sentiment))
        }
        .chartForegroundStyleScale([
            JournalEntry.Sentiment.positive.rawValue: JournalEntry.Sentiment.positive.sentimentColor,
            JournalEntry.Sentiment.negative.rawValue: JournalEntry.Sentiment.negative.sentimentColor,
            JournalEntry.Sentiment.neutral.rawValue: JournalEntry.Sentiment.neutral.sentimentColor
        ])
        .chartLegend(position: .trailing, alignment: .center)
        .frame(height: 200)
        .padding()
    }
}

/*#Preview {
    ChartView()
}*/

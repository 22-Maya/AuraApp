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
        VStack(alignment: .leading) {
            Text("Mood Overview")
                .font(.system(.title, design: .serif, weight: .semibold))
                .padding(.top, 12)
                .padding(.horizontal)
            Chart(entries) { entry in
                SectorMark(angle: .value("Type", 1))
                    .foregroundStyle(by: .value("sentiment", entry.sentiment))
            }
            .foregroundStyle(by: .value("Sentiment", data.sentiment.rawValue))
            .annotation(position: .overlay) {
                Text("\(data.count)")
                    .font(.system(.caption, design: .serif))
                    .foregroundColor(.white)
            }
            .chartForegroundStyleScale([
                JournalEntry.Sentiment.positive.rawValue: JournalEntry.Sentiment.positive.sentimentColor,
                JournalEntry.Sentiment.negative.rawValue: JournalEntry.Sentiment.negative.sentimentColor,
                JournalEntry.Sentiment.neutral.rawValue: JournalEntry.Sentiment.neutral.sentimentColor
            ])
            .chartLegend {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(JournalEntry.Sentiment.allCases, id: \.self) { sentiment in
                        HStack(alignment: .center, spacing: 4) {
                            Circle()
                                .fill(Color(sentiment.sentimentColor))
                                .frame(width: 9, height: 9)
                            Text(sentiment.sentimentIcon)
                                .font(.system(.body, design: .serif))
                        }
                    }
                }
            }
            .frame(height: 300)
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(red: 69/255.0, green: 54/255.0, blue: 89/255.0), lineWidth: 1.5)
                    .background(Color.white.opacity(0.2))
            )
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
}

#Preview {
    let sampleEntries = [
        JournalEntry(title: "Happy", text: "Great day", date: Date(), sentimentScore: 0.8),
        JournalEntry(title: "Okay", text: "Normal day", date: Date(), sentimentScore: 0.1),
        JournalEntry(title: "Sad", text: "Bad day", date: Date(), sentimentScore: -0.5)
    ]
    
    return ChartView(entries: sampleEntries)
}

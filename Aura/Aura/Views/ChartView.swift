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
    
    private var sentimentCounts: [JournalEntry.Sentiment: Int] {
        var counts: [JournalEntry.Sentiment: Int] = [
            .positive: 0,
            .negative: 0,
            .neutral: 0
        ]
        entries.forEach { counts[$0.sentiment]? += 1 }
        return counts
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text("Mood Overview")
                .font(.system(size: 40, weight: .semibold, design: .serif))
                .padding(.top, 12)
                .padding(.bottom, 17)
                .padding(.horizontal)
                .foregroundStyle(Color(red: 49/255.0, green: 39/255.0, blue: 63/255.0))
            
            Chart {
                ForEach(JournalEntry.Sentiment.allCases, id: \.self) { sentiment in
                    SectorMark(
                        angle: .value("Count", sentimentCounts[sentiment] ?? 0),
                        angularInset: 0.5
                    )
                    .foregroundStyle(by: .value("Sentiment", sentiment.rawValue))
                }
            }
            .chartForegroundStyleScale([
                JournalEntry.Sentiment.positive.rawValue: JournalEntry.Sentiment.positive.sentimentColor,
                JournalEntry.Sentiment.negative.rawValue: JournalEntry.Sentiment.negative.sentimentColor,
                JournalEntry.Sentiment.neutral.rawValue: JournalEntry.Sentiment.neutral.sentimentColor
            ])
            .chartLegend {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(JournalEntry.Sentiment.allCases, id: \.self) { sentiment in
                        HStack(alignment: .firstTextBaseline, spacing: 6) {
                            Circle()
                                .fill(sentiment.sentimentColor)
                                .frame(width: 12, height: 12)
                            
                            // Format the text with fixed-width numbers
                            Text("\(sentiment.sentimentIcon) \(String(format: "%2d", sentimentCounts[sentiment] ?? 0))")
                                .font(.system(size: 20, design: .monospaced))
                                .frame(width: 200, alignment: .leading) // Fixed width for consistent alignment
                        }
                    }
                }
                .padding(.top, 25)
                .padding(.leading, 8) // Add some padding to match your design
            }
            .frame(height: 450)
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

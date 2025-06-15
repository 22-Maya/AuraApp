//
//  JournalEntryRow.swift
//  Aura
//
//  Created by Student on 6/15/25.
//

import SwiftUI
import SwiftData

struct JournalEntryRow: View {
    let entry: JournalEntry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(entry.title)
                .font(.system(.headline, design: .serif))
                .lineLimit(1)
            
            HStack {
                Text(entry.formattedDate)
                    .font(.system(.caption, design: .serif))
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Text(entry.sentiment)
                    .font(.system(.subheadline, design: .serif))
                    .foregroundColor(sentimentColor)
            }
        }
        .padding(.vertical, 8)
    }
    
    private var sentimentColor: Color {
        switch entry.sentimentScore {
        case ..<(-0.5): return .red
        case 0.5...: return .green
        default: return .gray
        }
    }
}

#Preview {
    let sampleEntry = JournalEntry(
        title: "Sample Journal Entry",
        text: "This is a sample journal entry content that would normally be longer.",
        date: Date(),
        sentimentScore: 0.8
    )
    
    return JournalEntryRow(entry: sampleEntry)
        .padding()
        .background(Color(red: 235/255.0, green: 236/255.0, blue: 255/255.0))
}

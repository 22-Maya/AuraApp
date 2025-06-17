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
                
                Text(entry.sentimentIcon)
                    .font(.system(.subheadline, design: .serif))
                    .foregroundStyle(entry.sentimentColor)
            }
        }
        .padding(.vertical, 8)
    }
    
}

#Preview {
    JournalEntryRow(entry: JournalEntry(title: "Sample Journal Entry", text: "This is a sample journal entry content that would normally be longer.", date: Date(), sentimentScore: 0.8))
        .padding()
        .background(Color(red: 235/255.0, green: 236/255.0, blue: 255/255.0))
}

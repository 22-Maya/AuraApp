//
//  EntryView.swift
//  Aura
//
//  Created by Student on 6/10/25.
//

import SwiftUI
import SwiftData

struct EntryView: View {
    let entry: JournalEntry
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 235/255.0, green: 236/255.0, blue: 255/255.0),
                    Color(red: 141/255.0, green: 140/255.0, blue: 207/255.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text(entry.sentimentIcon)
                        .font(.system(.title3, design: .serif))
                        .foregroundStyle(entry.sentimentColor)
                    Spacer()
                    Text(entry.formattedDate)
                        .font(.system(.subheadline, design: .serif))
                        .foregroundStyle(.secondary)
                }
                
                ScrollView {
                    Text(entry.text)
                        .font(.system(.body, design: .serif))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .background(Color(red: 235/255.0, green: 236/255.0, blue: 255/255.0))
                .cornerRadius(10)
                .shadow(radius: 2)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Journal Entry")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    EntryView(entry: JournalEntry(title: "Amazing Day", text: "Today was a productive day. I finished all my tasks and felt accomplished.", date: Date(), sentimentScore: 1.0))
}

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
            Color(red: 141/255.0, green: 140/255.0, blue: 207/255.0)
            .ignoresSafeArea()
            
            VStack {
                Text("\(entry.title)")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 35, weight: .bold, design: .serif))
                    .foregroundStyle(Color(red: 49/255.0, green: 39/255.0, blue: 63/255.0))
                
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
                    .padding()
                    .background(Color(red: 235/255.0, green: 236/255.0, blue: 255/255.0))
                    .cornerRadius(10)
                    
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
                .padding(.bottom)
                .padding(.horizontal)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    EntryView(entry: JournalEntry(title: "Amazing Day", text: "Today was a productive day. I finished all my tasks and felt accomplished.", date: Date(), sentimentScore: 1.0))
}

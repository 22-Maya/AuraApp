//
//  NewEntryView.swift
//  Aura
//
//  Created by Student on 6/10/25.
//

import SwiftUI
import SwiftData

struct NewEntryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var text = ""
    @State private var date: Date = Date()
    @State private var showDatePicker = false
    @State private var sentimentScore: Double?
    private let scorer = Scorer.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 141/255.0, green: 140/255.0, blue: 207/255.0)
                
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 30) {
                        // Date picker
                        DateSelectorView(selectedDate: $date)
                            .padding(.horizontal)
                        
                        TextEditor(text: $text)
                            .font(.system(.body, design: .serif))
                            .frame(minHeight: 200)
                            .padding()
                            .background(Color(red: 235/255.0, green: 236/255.0, blue: 255/255.0))
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                        
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("New Entry")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.system(size: 20, weight: .regular, design: .serif))
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button("Save", action: save)
                        .disabled(text.isEmpty)
                        .font(.system(size: 20, weight: .regular, design: .serif))
                }
            }
            .onChange(of: text) {
                analyzeSentiment()
            }
        }
    }
    
    private func analyzeSentiment() {
        guard !text.isEmpty else {
            sentimentScore = nil
            return
        }
        sentimentScore = scorer.score(text)
    }
    
    private func save() {
        let score = scorer.score(text)
        let entry = JournalEntry(text: text, date: date, sentimentScore: score)
        modelContext.insert(entry)
        dismiss()
    }
}

#Preview {
    NewEntryView()
}

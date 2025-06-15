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
    
    @State private var title = ""
    @State private var text = ""
    @State private var date: Date = Date()
    @State private var showDatePicker = false
    @State private var sentimentScore: Double?
    private let scorer = Scorer.shared
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color(red: 49/255.0, green: 39/255.0, blue: 63/255.0))]
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 141/255.0, green: 140/255.0, blue: 207/255.0)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        HStack {
                            Spacer()
                            DateSelectorView(selectedDate: $date)
                        }
                        .padding(.horizontal)
                        
                        TextField("Enter a title...", text: $title)
                            .font(.system(.body, design: .serif))
                            .padding(15)
                            .background(Color(red: 235/255.0, green: 236/255.0, blue: 255/255.0))
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Journal Entry")
                                .font(.system(size: 17, design: .serif))
                                .foregroundColor(Color(red: 235/255.0, green: 236/255.0, blue: 255/255.0))
                                .padding(.horizontal, 5)
                            
                            TextEditor(text: $text)
                                .font(.system(.body, design: .serif))
                                .frame(minHeight: 200)
                                .padding()
                                .background(Color(red: 235/255.0, green: 236/255.0, blue: 255/255.0))
                                .cornerRadius(10)
                                .shadow(radius: 2)
                        }
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
                    Button("Save") {
                        saveEntry()
                    }
                    .disabled(title.isEmpty || text.isEmpty)
                    .font(.system(size: 20, weight: .regular, design: .serif))
                }
            }
        }
    }
    
    private func analyzeSentiment() {
        sentimentScore = text.isEmpty ? nil : scorer.score(text)
    }
    
    private func saveEntry() {
        let score = sentimentScore ?? 0.0
        let newEntry = JournalEntry(
            title: title,
            text: text,
            date: date,
            sentimentScore: score
        )
        modelContext.insert(newEntry)
        dismiss()
    }
}

#Preview {
    NewEntryView()
        .modelContainer(for: JournalEntry.self)
}

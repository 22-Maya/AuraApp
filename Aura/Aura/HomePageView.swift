//
//  HomePageView.swift
//  Aura
//
//  Created by Student on 6/10/25.
//

import SwiftUI
import SwiftData

struct HomePageView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \JournalEntry.date, order: .reverse) private var entries: [JournalEntry]
    @State private var isShowingNewEntry = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(entries) {
                    entry in NavigationLink {
                        EntryView(entry: entry)
                    }
                    label: {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(entry.formattedDate)
                                .font(.system(.caption, design: .serif))
                                .foregroundStyle(.secondary)
            
                            Text(entry.date, format: Date.FormatStyle(date: .numeric, time: .shortened))
                                .font(.system(.body, design: .serif))
                            
                            HStack {
                                Text(entry.sentiment)
                                    .font(.system(.subheadline, design: .serif))
                                Spacer()
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .onDelete(perform: deleteEntries)
                .listRowBackground(Color(red: 235/255.0, green: 236/255.0, blue: 255/255.0))
            }
            .navigationTitle("Aura Journal")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingNewEntry = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color(red: 69/255.0, green: 54/255.0, blue: 89/255.0))
                    }
                }
            }
            .sheet(isPresented: $isShowingNewEntry) {
                NewEntryView()
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 235/255.0, green: 236/255.0, blue: 255/255.0),
                        Color(red: 141/255.0, green: 140/255.0, blue: 207/255.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
        }
    }
    
    private func deleteEntries(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(entries[index])
        }
    }
}

#Preview {
    HomePageView()
}

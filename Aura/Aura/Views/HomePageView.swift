//
//  HomePageView.swift
//  Aura
//
//  Created by Student on 6/10/25.
//

import SwiftUI
import SwiftData
import Charts

struct HomePageView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \JournalEntry.date, order: .reverse) private var entries: [JournalEntry]
    @State private var isShowingNewEntry = false
    
    var body: some View {
        TabView {
            // Journal Tab
            NavigationStack {
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
                    
                    List {
                        ForEach(entries) { entry in
                            NavigationLink {
                                EntryView(entry: entry)
                            } label: {
                                JournalEntryRow(entry: entry)
                            }
                            .listRowBackground(Color(red: 235/255.0, green: 236/255.0, blue: 255/255.0))
                            .listRowSeparatorTint(Color(red: 69/255.0, green: 54/255.0, blue: 89/255.0))
                        }
                        .onDelete(perform: deleteEntries)
                    }
                    .scrollContentBackground(.hidden)
                    .overlay {
                        if entries.isEmpty {
                            ContentUnavailableView(
                                "No Entries Yet",
                                systemImage: "book.closed.fill",
                                description: Text("Tap + to create your first journal entry")
                            )
                        }
                    }
                }
                .navigationTitle("Your Aura Journal")
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
            }
            .tabItem {
                Label("Journal", systemImage: "book.fill")
            }
            .tag(0)
            
            // Insights Tab
            NavigationStack {
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
                    
                    ChartView(entries: entries)
                }
            }
            .tabItem {
                Label("Insights", systemImage: "chart.pie.fill")
            }
            .tag(1)
            
            // Tips Tab
            NavigationStack {
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
                    
                    TipsView()
                }
            }
            .tabItem {
                Label("Tips", systemImage: "lightbulb.fill")
            }
            .tag(2)
        }
        .tint(Color(red: 69/255.0, green: 54/255.0, blue: 89/255.0))
    }
    
    private func deleteEntries(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(entries[index])
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: JournalEntry.self, configurations: config)
    
    let sampleEntry = JournalEntry(
        title: "My First Entry",
        text: "Today was a wonderful day!",
        date: Date(),
        sentimentScore: 0.8
    )
    container.mainContext.insert(sampleEntry)
    
    return HomePageView()
        .modelContainer(container)
}

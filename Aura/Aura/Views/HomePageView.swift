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
            NavigationView {
                VStack(spacing: 0) {
                    HStack {
                        Text("Aura Journal")
                            .font(.system(size: 40, weight: .semibold, design: .serif))
                            .foregroundColor(Color(red: 49/255.0, green: 39/255.0, blue: 63/255.0))
                        
                        Spacer()
                        Button(action: {
                            isShowingNewEntry = true
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color(red: 69/255.0, green: 54/255.0, blue: 89/255.0))
                                .padding(8)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(Color(red: 188/255.0, green: 188/255.0, blue: 231/255.0))
                    
                    ZStack {
                        Color(red: 188/255.0, green: 188/255.0, blue: 231/255.0)
                            .ignoresSafeArea()
                        
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(entries) { entry in
                                    NavigationLink(destination: EntryView(entry: entry)) {
                                        JournalEntryRow(entry: entry)
                                            .padding(.horizontal)
                                            .padding(.vertical, 8)
                                            .background(Color(red: 235/255.0, green: 236/255.0, blue: 255/255.0))
                                            .cornerRadius(10)
                                            .padding(.horizontal, 15)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.top, 10)
                        }
                        
                        if entries.isEmpty {
                            ContentUnavailableView(
                                "No Entries Yet",
                                systemImage: "book.closed.fill",
                                description: Text("Tap + to create your first journal entry")
                            )
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
            
            NavigationView {
                ZStack {
                    Color(red: 188/255.0, green: 188/255.0, blue: 231/255.0)
                        .ignoresSafeArea()
                    
                    ChartView(entries: entries)
                }
            }
            .tabItem {
                Label("Insights", systemImage: "chart.pie.fill")
            }
            
            NavigationView {
                ZStack {
                    Color(red: 188/255.0, green: 188/255.0, blue: 231/255.0)
                        .ignoresSafeArea()
                    
                    TipsView()
                }
            }
            .tabItem {
                Label("Tips", systemImage: "lightbulb.fill")
            }
        }
        .accentColor(Color(red: 69/255.0, green: 54/255.0, blue: 89/255.0))
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

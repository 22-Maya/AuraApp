// HomePageView.swift
// Aura

import SwiftUI
import SwiftData
import Charts

struct HomePageView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \JournalEntry.date, order: .reverse) private var entries: [JournalEntry]
    @State private var isShowingNewEntry = false
    
    var body: some View {
        TabView {
            journalTab
            insightsTab
            tipsTab
        }
        .tint(Color(red: 69/255.0, green: 54/255.0, blue: 89/255.0))
    }
    
    // MARK: - Tab Views
    
    private var journalTab: some View {
        NavigationView {
            VStack(spacing: 0) {
                journalHeader
                journalContent
            }
        }
        .tabItem {
            Label("Journal", systemImage: "book.fill")
        }
    }
    
    private var insightsTab: some View {
        NavigationView {
            ZStack {
                backgroundColor
                ChartView(entries: entries)
            }
        }
        .tabItem {
            Label("Insights", systemImage: "chart.pie.fill")
        }
    }
    
    private var tipsTab: some View {
        NavigationView {
            ZStack {
                backgroundColor
                TipsView()
            }
        }
        .tabItem {
            Label("Tips", systemImage: "lightbulb.fill")
        }
    }
    
    // MARK: - Subviews
    
    private var journalHeader: some View {
        HStack {
            Text("Aura Journal")
                .font(.system(size: 40, weight: .semibold, design: .serif))
                .foregroundColor(mainTextColor)
            
            Spacer()
            Button(action: {
                isShowingNewEntry = true
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(buttonColor)
                    .padding(8)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .background(headerBackgroundColor)
    }
    
    private var journalContent: some View {
        ZStack {
            backgroundColor
            entriesList
            if entries.isEmpty {
                emptyStateView
            }
        }
        .sheet(isPresented: $isShowingNewEntry) {
            NewEntryView()
        }
    }
    
    private var entriesList: some View {
        List {
            ForEach(entries) { entry in
                NavigationLink(destination: EntryView(entry: entry)) {
                    JournalEntryRow(entry: entry)
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .background(rowBackgroundColor)
                        .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        deleteEntry(entry)
                    } label: {
                        Label("Delete", systemImage: "trash.fill")
                    }
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
            }
        }
        .listStyle(PlainListStyle())
        .padding(.top, 10)
    }
    
    private var emptyStateView: some View {
        ContentUnavailableView(
            "No Entries Yet",
            systemImage: "book.closed.fill",
            description: Text("Tap + to create your first journal entry")
        )
    }
    
    // colors
    
    private var backgroundColor: some View {
        Color(red: 188/255.0, green: 188/255.0, blue: 231/255.0)
            .ignoresSafeArea()
    }
    
    private var headerBackgroundColor: Color {
        Color(red: 188/255.0, green: 188/255.0, blue: 231/255.0)
    }
    
    private var rowBackgroundColor: Color {
        Color(red: 235/255.0, green: 236/255.0, blue: 255/255.0)
    }
    
    private var mainTextColor: Color {
        Color(red: 49/255.0, green: 39/255.0, blue: 63/255.0)
    }
    
    private var buttonColor: Color {
        Color(red: 69/255.0, green: 54/255.0, blue: 89/255.0)
    }
    
    // methods
    
    private func deleteEntry(_ entry: JournalEntry) {
        withAnimation {
            modelContext.delete(entry)
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

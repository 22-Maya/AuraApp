//
//  AuraApp.swift
//  Aura
//
//  Created by Student on 6/10/25.
//

import SwiftUI
import SwiftData

@main
struct AuraApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: JournalEntry.self)
    }
}

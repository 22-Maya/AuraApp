//
//  TipsView.swift
//  Aura
//
//  Created by Student on 6/10/25.
//

import SwiftUI

struct TipsView: View {
    
    let tips: [(sentiment: String, suggestions: [String])] = [
        ("Positive", [
            "• Share your positive energy with others.",
            "• Reflect on what made your day great and note it down.",
            "• Set a new, exciting goal.",
            "• Help someone else achieve their goal.",
            "• Spend time in nature.",
            "• Treat yourself to something small and enjoyable.",
            "• Plan how to carry this positive momentum forward."
        ]),
        ("Balanced", [
            "• Learn something new (a skill, a fact).",
            "• Organize a small part of your living space.",
            "• Plan a fun activity for later in the week.",
            "• Try a new recipe.",
            "• Engage in a hobby you enjoy.",
            "• Take a short break and stretch.",
            "• Do a quick random act of kindness."
        ]),
        ("Negative", [
            "• Go for a walk or light exercise.",
            "• Listen to uplifting music.",
            "• Call a supportive friend or family member.",
            "• Practice deep breathing or meditation.",
            "• Write down your feelings in a journal.",
            "• Watch a comforting movie or show.",
            "• Do something small that brings you joy, like read a book."
        ])
    ]
    
    @State private var expandedSections: Set<String> = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text("Daily Suggestions")
                        .font(.system(size: 40, weight: .semibold, design: .serif))
                        .foregroundColor(Color(red: 49/255.0, green: 39/255.0, blue: 63/255.0))
                    Spacer()
                }
                .padding(.bottom, 8)
                
                ForEach(tips, id: \.sentiment) { tipSection in
                    VStack(spacing: 5) {
                        
                        Button(action: {
                            withAnimation {
                                if expandedSections.contains(tipSection.sentiment) {
                                    expandedSections.remove(tipSection.sentiment)
                                } else {
                                    expandedSections.insert(tipSection.sentiment)
                                }
                            }
                        }) {
                            HStack {
                                Text(tipSection.sentiment + " Day")
                                    .font(.system(.headline, design: .serif))
                                    .foregroundColor(Color(red: 49/255.0, green: 39/255.0, blue: 63/255.0))
                                
                                Spacer()
                                
                                Image(systemName: expandedSections.contains(tipSection.sentiment) ? "chevron.up" : "chevron.down")
                                    .foregroundColor(Color(red: 69/255.0, green: 54/255.0, blue: 89/255.0))
                            }
                            .padding()
                            .background(Color(red: 235/255.0, green: 236/255.0, blue: 255/255.0))
                            .cornerRadius(8)
                        }
                        
                        if expandedSections.contains(tipSection.sentiment) {
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(tipSection.suggestions, id: \.self) { tip in
                                    Text(tip)
                                        .font(.system(size: 18, design: .serif))
                                        .padding(.leading, 5)
                                }
                            }
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(8)
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color(red: 188/255.0, green: 188/255.0, blue: 231/255.0))
    }
}

#Preview {
    TipsView()
}

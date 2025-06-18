//
//  TipsView.swift
//  Aura
//
//  Created by Student on 6/16/25.
//

import SwiftUI

struct TipsView: View {
    let tips = [
        ("Positive 😊", [
            "Share your positive energy with others.",
            "Reflect on what made your day great and note it down.",
            "Set a new, exciting goal.",
            "Help someone else achieve their goal.",
            "Spend time in nature.",
            "Treat yourself to something small and enjoyable.",
            "Plan how to carry this positive momentum forward."
        ]),
        ("Neutral 😐", [
            "Try a new activity to spark interest",
            "Practice mindfulness meditation",
            "Connect with friends or family"
        ]),
        ("Negative 😞", [
            "Identify specific concerns in your journal",
            "Practice deep breathing exercises",
            "Consider talking to a professional"
        ])
    ]
    
    var body: some View {
        ZStack {
            Color(red: 188/255.0, green: 188/255.0, blue: 231/255.0)
            .ignoresSafeArea()
            
            ScrollView {
                Text("Mood Improvement Tips")
                    .font(.system(size: 40, weight: .semibold, design: .serif))
                    .padding(.top, 12)
                    .padding(.bottom, 17)
                    .padding(.horizontal, 15)
                    .foregroundStyle(Color(red: 49/255.0, green: 39/255.0, blue: 63/255.0))
                    .multilineTextAlignment(.leading)
                
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(tips, id: \.0) { category in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(category.0)
                                .font(.system(.title2, design: .serif))
                                .padding(.horizontal)
                            
                            ForEach(category.1, id: \.self) { tip in
                                Text("• \(tip)")
                                    .font(.system(.body, design: .serif))
                                    .padding(.horizontal, 30)
                            }
                        }
                    }
                }
                .padding(.top)
            }
        }
    }
}

#Preview {
    TipsView()
}

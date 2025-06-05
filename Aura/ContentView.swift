//
//  ContentView.swift
//  Aura
//
//  Created by Student on 6/4/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            Text("Welcome \nTo Aura")
                .font(.system(size: 60))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 69/255.0, green: 54/255.0, blue: 89/255.0))
        	Button("Enter")
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Make VStack fill available space
        .background(
            RadialGradient(
                gradient: Gradient(colors: [
                    Color(red: 235/255.0, green: 236/255.0, blue: 255/255.0),
                    //Color(red: 164/255.0, green: 173/255.0, blue: 224/255.0),
                    Color(red: 141/255.0, green: 140/255.0, blue: 207/255.0)]),
                center: .center, // Specify the center point
                startRadius: 50, // Inner radius
                endRadius: 200 // Outer radius
            )
            .ignoresSafeArea() // Make the gradient ignore safe areas
        )
    }
}

#Preview {
    ContentView()
}

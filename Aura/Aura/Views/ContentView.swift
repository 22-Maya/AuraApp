//
//  ContentView.swift
//  Aura
//
//  Created by Student on 6/4/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack {
                    Text("Welcome \nTo Aura")
                        .font(.system(size: 60, weight: .semibold, design: .serif))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color(red: 69/255.0, green: 54/255.0, blue: 89/255.0))
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color(red: 235/255.0, green: 236/255.0, blue: 255/255.0),
                            Color(red: 141/255.0, green: 140/255.0, blue: 207/255.0)]),
                        center: .center,
                        startRadius: 50,
                        endRadius: 200
                    )
                )
                .ignoresSafeArea()
                
                NavigationLink(destination: HomePageView().navigationBarBackButtonHidden(true)) {
                    Text("Enter")
                        .padding()
                        .font(.system(size: 40, design: .serif))
                        .background(Color(red: 235/255.0, green: 236/255.0, blue: 255/255.0))
                        .cornerRadius(25)
                        .foregroundStyle(Color(red: 69/255.0, green: 54/255.0, blue: 89/255.0))
                }
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    ContentView()
}

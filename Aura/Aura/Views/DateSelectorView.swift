//
//  DateSelectorView.swift
//  Aura
//
//  Created by Student on 6/10/25.
//

import SwiftUI

struct DateSelectorView: View {
    @Binding var selectedDate: Date
    @State private var showCalendar = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Button(action: {
                withAnimation {
                    showCalendar.toggle()
                }
            }) {
                HStack {
                    Image(systemName: "calendar")
                    Text(selectedDate.formatted(date: .abbreviated, time: .shortened))
                        .font(.system(.subheadline, design: .serif))
                }
                .padding()
                .background(Color(red: 235/255.0, green: 236/255.0, blue: 255/255.0))
                .cornerRadius(8)
                .foregroundColor(Color(red: 69/255.0, green: 54/255.0, blue: 89/255.0))
            }
            
            // Expanded Calendar
            if showCalendar {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(.graphical)
                .padding()
                .background(Color(red: 235/255.0, green: 236/255.0, blue: 255/255.0))
                .cornerRadius(10)
                .transition(.scale.combined(with: .opacity))
            }
        }
    }
}

#Preview {
    DateSelectorView(selectedDate: .constant(Date()))
}

//
//  WeeklyCalendarView.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2024-03-11.
//

import SwiftUI

struct WeeklyCalendarView: View {
    @Binding var events: [EventItem]

    var body: some View {
        VStack {
            // Header: Weekday Names
            HStack {
                ForEach(Calendar.current.shortWeekdaySymbols, id: \.self) { weekday in
                    Text(weekday)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.vertical, 8)

            // Calendar Days
            ForEach(1..<8) { dayIndex in
                Text("\(dayIndex)")
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            }
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}

struct WeeklyCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyCalendarView(events: .constant([]))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}


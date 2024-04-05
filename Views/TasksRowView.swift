//
//  TasksView.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2024-03-14.
//

import SwiftUI

struct TasksRowView: View {
    let item: EventItem
    
    var body: some View {
        NavigationLink(destination: EventItemDetailView(item: item)) {
            HStack(alignment: .top, spacing: 15) {
                let eventDate = Date(timeIntervalSince1970: item.date)
                Circle()
                    .fill(indicatorColor)
                    .frame(width: 10, height: 10)
                    .padding(4)
                    .shadow(color: Color.black.opacity(0.1), radius: 3)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text(item.title)
                        .font(.body)
                    Label("\(Date(timeIntervalSince1970: item.date).formatted(date: .abbreviated, time: .shortened))", systemImage: "clock")
                        .captionStyle()
                        .foregroundColor(Color(.secondaryLabel))
                })
                .padding(15)
                .hSpacing(.leading)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("TaskBGColor")))
                .strikethrough(eventDate.isPast, pattern: .solid, color: .black)
                .offset(y: -8)
            }
            .contentShape(Rectangle()) // Ensure the whole row is tappable
        }
    }
    
    var indicatorColor: Color {
        let eventDate = Date(timeIntervalSince1970: item.date)
        print(item.title)
        print("here is the event date", eventDate)
        if eventDate.isAhead {
            return .gray
        }
        
        return eventDate.isSameHour ? .blue : (eventDate.isPast ? .red : .black)
    }
}

struct TasksRowView_Previews: PreviewProvider {
    static var previews: some View {
        TasksRowView(item: .init(id: "123",
                                 title: "Birthday",
                                 date: Date().timeIntervalSince1970,
                                 location: "Cottage",
                                 description: "My 21st Birthday Party!"
                                ))
    }
}

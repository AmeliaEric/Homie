//
//  Event.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2024-03-10.
//

import Foundation

struct EventItem: Codable, Identifiable{
    var id: String
    var title: String
    var date: TimeInterval
    var location: String
    var description: String
//    var createdBy: String
//    var familyGroupNumber: Int
    
    var eventDate: Date {
        return Date(timeIntervalSince1970: date)
    }
}

var sampleEvents: [EventItem] = [
    EventItem(id: "123h", title: "Birthday", date: Date().timeIntervalSince1970 + 88400, location: "Cottage", description: "My 21st Birthday Party!"),
    
    EventItem(id: "123i", title: "Project Due", date: Date().timeIntervalSince1970 + 96400, location: "Cottage", description: "My 21st Birthday Party!"),
    
    EventItem(id: "123j", title: "Birthday", date: Date().timeIntervalSince1970 + 76400, location: "Cottage", description: "My 21st Birthday Party!"),
    
    EventItem(id: "123k", title: "Birthday", date: Date().timeIntervalSince1970 + 87400, location: "Cottage", description: "My 21st Birthday Party!"),
    
    EventItem(id: "123l", title: "Birthday", date: Date().timeIntervalSince1970 + 86900, location: "School", description: "My 21st Birthday Party!")

]

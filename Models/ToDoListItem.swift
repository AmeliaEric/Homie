//
//  ToDoListItem.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2023-08-27.
//

import Foundation

struct ToDoListItem: Codable, Identifiable {
    let id: String
    var title: String
    var description: String
    var dueDate: TimeInterval
    let createDate: TimeInterval
    var isDone: Bool
//    let assignedTo: String
//    let createdBy: String
//    var familyGroupNumber: Int
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}
var sampleTasks: [ToDoListItem] = [
    ToDoListItem(id: "1", title: "Finish coding project", description: "Complete all the remaining tasks for the coding project", dueDate: Date().timeIntervalSince1970 + 86400, createDate: Date().timeIntervalSince1970, isDone: false),
    ToDoListItem(id: "2", title: "Buy groceries", description: "Purchase fruits, vegetables, and other essentials", dueDate: Date().timeIntervalSince1970 + 172800, createDate: Date().timeIntervalSince1970, isDone: false),
    ToDoListItem(id: "3", title: "Prepare presentation slides", description: "Create slides for the upcoming meeting", dueDate: Date().timeIntervalSince1970 + 259200, createDate: Date().timeIntervalSince1970, isDone: false)
]
extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}

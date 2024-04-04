//
//  User.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2023-08-27.
//

import Foundation

struct User: Codable, Hashable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
//    var familyGroupNumber: Int
//    var age: Int?
//    var likes: [String]?
//    var dislikes: [String]?
//    var allergies: [String]?
//    var medicalInformation: String?
}

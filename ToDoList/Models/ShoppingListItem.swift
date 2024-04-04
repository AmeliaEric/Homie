//
//  ShoppingListItem.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2024-03-06.
//

import Foundation

struct ShoppingListItem: Codable, Identifiable {
    let id: String
    var name: String
    var quantity: Int
    var isPurchased: Bool
    var preferredBrand: String?
    var preferredStore: String?
    let createDate: TimeInterval
//    let createdBy: String
//    var familyGroupNumber: Int

    mutating func markAsPurchased(_ state: Bool) {
        isPurchased = state
    }
}
var sampleShoppingItems: [ShoppingListItem] = [
    ShoppingListItem(id: "1",
                     name: "Apples",
                     quantity: 2,
                     isPurchased: false,
                     preferredBrand: "Green Apples",
                     preferredStore: "Local Grocery",
                     createDate: Date().timeIntervalSince1970),
    ShoppingListItem(id: "2",
                     name: "Milk",
                     quantity: 1,
                     isPurchased: false,
                     preferredBrand: nil,
                     preferredStore: "Supermarket",
                     createDate: Date().timeIntervalSince1970),
    ShoppingListItem(id: "3",
                     name: "Bread",
                     quantity: 1,
                     isPurchased: false,
                     preferredBrand: nil,
                     preferredStore: "Bakery",
                     createDate: Date().timeIntervalSince1970)
]

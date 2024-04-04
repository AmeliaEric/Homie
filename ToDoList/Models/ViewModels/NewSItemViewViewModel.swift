//
//  NewSItemViewViewModel.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2024-03-01.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class NewShoppingItemViewViewModel: ObservableObject {
    @Published var name = ""
    @Published var quantity = ""
    @Published var preferredBrand = ""
    @Published var preferredStore = ""
    @Published var showAlert = false
    @Published var createdBy = "creatorUserId"
    
    init() {}
    
    func save() {
        guard canSave else {
            return
        }
        
        // Get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        // Create model
        let newId = UUID().uuidString
        guard let quantityInt = Int(quantity) else {
            return
        }
        let newShoppingItem = ShoppingListItem(
                id: newId,
                name: name,
                quantity: quantityInt,
                isPurchased: false,
                preferredBrand: preferredBrand.isEmpty ? nil : preferredBrand, // Use nil if preferred brand is empty
                preferredStore: preferredStore.isEmpty ? nil : preferredStore, // Use nil if preferred store is empty
                createDate: Date().timeIntervalSince1970
//                createdBy: createdBy,// Provide the ID of the user who created the item,
//                familyGroupNumber: 1// Provide the family group number
            )
        
        // Save model
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("shopping")
            .document(newId)
            .setData(newShoppingItem.asDictionary())
    }
    
    var canSave: Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard let quantityInt = Int(quantity), quantityInt > 0 else {
            return false
        }
        
        return true
    }
}

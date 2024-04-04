//
//  ShoppingListViewViewModel.swift
//  ShoppingList
//  Description: View of total list of shopping items (Primary Shopping Tab)
//  Created by Amelia Eric-Markovic on 2024-02-29.
//

import FirebaseFirestore
import Foundation

class ShoppingListViewViewModel: ObservableObject {
    @Published var showingNewShoppingItemView = false
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    /// Delete shopping list item
    /// - Parameter id: item id to delete
    func delete(id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("shopping")
            .document(id)
            .delete()
    }
}


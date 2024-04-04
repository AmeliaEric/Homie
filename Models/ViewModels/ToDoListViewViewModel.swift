//
//  ToDoListViewViewModel.swift
//  ToDoList
//  Description: View of total list of items (Primary Task/Tab)
//  Created by Amelia Eric-Markovic on 2023-08-27.
//

import FirebaseFirestore
import Foundation

class ToDoListViewViewModel: ObservableObject{
    @Published var showingNewItemView = false
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    /// Delete to do list item
    /// - Parameter id: item id to delete
    func delete(id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
}

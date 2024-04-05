//
//  EventViewViewModel.swift
//  ToDoListxs
//
//  Created by Amelia Eric-Markovic on 2024-03-01.
//

import FirebaseFirestore
import Foundation

class EventViewViewModel: ObservableObject {
    @Published var showingEventCreationView = false
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    /// Delete Event list item
    /// - Parameter id: item id to delete
    func delete(id: String) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("events")
            .document(id)
            .delete()
    }
}


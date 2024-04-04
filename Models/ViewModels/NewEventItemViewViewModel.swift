//
//  NewEItemViewViewModel.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2024-03-13.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class NewEventItemViewViewModel: ObservableObject{
    @Published var title = ""
    @Published var date = Date()
    @Published var location = ""
    @Published var description = ""
    @Published var showAlert = false

    init() {}
    
    func save() {
        guard canSave else {
            return
        }
        // get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        // create model
        let newId = UUID().uuidString
        let newEvent = EventItem(id: newId,
                                title: title,
                                date: date.timeIntervalSince1970,
                                location: location,
                                description: description)
  
        // save model
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("events")
            .document(newId)
            .setData(newEvent.asDictionary())
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard date >= Date().addingTimeInterval(-86400) else {
            return false
        }
        
        return true
    }
}

//
//  EventListItemViewViewModel.swift
//  ToDoList
//  Description: View for creating new item for list
//  Created by Amelia Eric-Markovic on 2023-08-27.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class EventListItemViewViewModel: ObservableObject{
    @Published var showingNewItemView = false
    init() {}
    
    func toggleIsPast(item: ToDoListItem) {
        var itemCopy = item
        //itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("events")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
}

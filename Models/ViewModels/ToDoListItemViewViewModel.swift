//
//  ToDoListItemViewViewModel.swift
//  ToDoList
//  Description: View for creating new item for list
//  Created by Amelia Eric-Markovic on 2023-08-27.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class ToDoListItemViewViewModel: ObservableObject{
    @Published var showingNewItemView = false
    init() {}
    
    func toggleIsDone(item: ToDoListItem) {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
}

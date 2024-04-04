//
//  NewItemViewViewModel.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2023-08-27.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

class NewItemViewViewModel: ObservableObject{
    @Published var title = ""
    @Published var description = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    @Published var assignedTo = "assignedUserId"
    @Published var familyMembers: [User] = []
//    init() {fetchFamilyMembers()}
//    func fetchFamilyMembers() {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            return
//        }
//
//        let db = Firestore.firestore()
//        db.collection("users").document(userId).getDocument { snapshot, error in
//            if let error = error {
//                print("Error fetching user document: \(error)")
//                return
//            }
//
//            guard let data = snapshot?.data(),
//                  let familyGroupNumber = data["familyGroupNumber"] as? Int else {
//                print("User document or family group number not found.")
//                return
//            }
//
//            // Fetch family members based on family group number
//            db.collection("users")
//                .whereField("familyGroupNumber", isEqualTo: familyGroupNumber)
//                .getDocuments { querySnapshot, error in
//                    if let error = error {
//                        print("Error fetching family members: \(error)")
//                        return
//                    }
//
//                    guard let documents = querySnapshot?.documents else {
//                        print("No family members found.")
//                        return
//                    }
//
//                    // Convert documents to User objects
//                    let members = documents.compactMap { queryDocumentSnapshot -> User? in
//                        do {
//                            let user = try queryDocumentSnapshot.data(as: User.self)
//                            return user
//                        } catch {
//                            print("Error decoding user: \(error)")
//                            return nil
//                        }
//                    }
//
//                    // Update familyMembers array
//                    DispatchQueue.main.async {
//                        self.familyMembers = members
//                    }
//                }
//        }
//    }
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
        let newItem = ToDoListItem(id: newId,
                                   title: title,
                                   description: description,
                                   dueDate: dueDate.timeIntervalSince1970,
                                   createDate: Date().timeIntervalSince1970,
                                   isDone: false)
//                                   assignedTo: assignedTo,
//                                   createdBy: uId,
//                                   familyGroupNumber: 1)
        
        // save model
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(newId)
            .setData(newItem.asDictionary())
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        
        return true
    }
}

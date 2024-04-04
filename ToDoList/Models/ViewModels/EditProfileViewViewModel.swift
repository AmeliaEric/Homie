////
////  EditProfileViewViewModel.swift
////  ToDoList
////
////  Created by Amelia Eric-Markovic on 2024-03-29.
////
//
//
//import FirebaseAuth
//import FirebaseFirestore
//import Foundation
//class EditProfileViewViewModel: ObservableObject {
//    @Published var age: Int?
//    @Published var likes: [String]?
//    // Add other properties for editing profile information as needed
//
//    init(user: User) {
//        self.age = user.age
//        self.likes = user.likes
//        // Initialize other properties based on the user's current profile
//    }
//
//    func saveChanges() {
//        guard canSaveChanges else {
//            return
//        }
//        
//        // Get current user id
//        guard let uId = Auth.auth().currentUser?.uid else {
//            return
//        }
//        
//        // Create model
//        let newId = UUID().uuidString
//
//        let updateProfile = User(
//            id: newId,
//            name: name,
//            email: email
//            joined: TimeInterval,
//            age: age,
//            likes: [String]?
//            var dislikes: [String]?
//            var allergies: [String]?
//            var medicalInformation: String?
//        )
//        
//        // Save model
//        let db = Firestore.firestore()
//        db.collection("users")
//            .document(uId)
//            .collection("shopping")
//            .document(newId)
//            .setData(newShoppingItem.asDictionary())
//    }
//    var canSaveChanges: Bool {
//        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
//            return false
//        }
//        
//        guard let quantityInt = Int(quantity), quantityInt > 0 else {
//            return false
//        }
//        
//        return true
//    }
//}
//

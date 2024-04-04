//
//  ProfileViewViewModel.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2023-08-27.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class ProfileViewViewModel: ObservableObject{
    init() {}
    
    @Published var user: User? = nil
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .getDocument { [weak self] snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self?.user = User(
                        id: data["id"] as? String ?? "",
                        name: data["name"] as? String ?? "",
                        email: data["email"] as? String ?? "",
                        joined: data["joined"] as? TimeInterval ?? 0
//                        familyGroupNumber: data["familyGroupNumber"] as? Int ?? 0,
//                        age: data["age"] as? Int,
//                        likes: data["likes"] as? [String],
//                        dislikes: data["dislikes"] as? [String],
//                        allergies: data["allergies"] as? [String],
//                        medicalInformation: data["medicalInformation"] as? String
                    )
                }
            }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    func updateProfile(user: User) {
            let db = Firestore.firestore()
            db.collection("users").document(user.id).setData([
                "name": user.name,
//                "age": user.age ?? NSNull(),
//                "likes": user.likes ?? NSNull(),
                /*let id: String
                 let name: String
                 let email: String
                 let joined: TimeInterval
                 var familyGroupNumber: Int
                 var age: Int?
                 var likes: [String]?
                 var dislikes: [String]?
                 var allergies: [String]?
                 var medicalInformation: String?*/
            ], merge: true) { error in
                if let error = error {
                    print("Error updating profile: \(error.localizedDescription)")
                } else {
                    print("Profile updated successfully")
                }
            }
        }
}

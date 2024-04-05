//
//  MainViewViewModel.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2023-08-27.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class MainViewViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    @Published var user: User? = nil
    //@Published var familyMembers: [User] = []
    @Published var taskCount: Int = 0
    @Published var doneTaskCount: Int = 0
    @Published var eventCount: Int = 0
    @Published var shoppingCount: Int = 0

    private var handler: AuthStateDidChangeListenerHandle?
    private var db = Firestore.firestore()

    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
                self?.fetchUserData()
                //self?.fetchFamilyMembers()
                self?.fetchTaskCount()
                self?.fetchDoneTaskCount()
                self?.fetchEventCount()
                self?.fetchShoppingCount()
            }
        }
    }

    private func fetchUserData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
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

//    private func fetchFamilyMembers() {
//            guard let userId = Auth.auth().currentUser?.uid else {
//                return
//            }
//            db.collection("users")
//                .whereField("familyGroupNumber", isEqualTo: user?.familyGroupNumber ?? 0)
//                .getDocuments { [weak self] snapshot, error in
//                    guard let snapshot = snapshot, error == nil else {
//                        return
//                    }
//                    var members: [User] = []
//                    for document in snapshot.documents {
//                        let data = document.data()
//                        let member = User(
//                            id: data["id"] as? String ?? "",
//                            name: data["name"] as? String ?? "",
//                            email: data["email"] as? String ?? "",
//                            joined: data["joined"] as? TimeInterval ?? 0,
//                            familyGroupNumber: data["familyGroupNumber"] as? Int ?? 0,
//                            age: data["age"] as? Int,
//                            likes: data["likes"] as? [String],
//                            dislikes: data["dislikes"] as? [String],
//                            allergies: data["allergies"] as? [String],
//                            medicalInformation: data["medicalInformation"] as? String
//                        )
//                        members.append(member)
//                    }
//                    DispatchQueue.main.async {
//                        self?.familyMembers = members
//                    }
//                }
//        }

    private func fetchTaskCount() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        db.collection("users")
            .document(userId)
            .collection("todos")
            .whereField("isDone", isEqualTo: false) // Only count incomplete tasks
            .addSnapshotListener { [weak self] snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    print("Error fetching tasks:", error?.localizedDescription ?? "Unknown error")
                    return
                }
                print("Fetched tasks:", snapshot.documents.count)
                DispatchQueue.main.async {
                    self?.taskCount = snapshot.documents.count
                }
            }
    }

    private func fetchDoneTaskCount() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        db.collection("users")
            .document(userId)
            .collection("todos")
            .whereField("isDone", isEqualTo: true) // Only count completed tasks
            .addSnapshotListener { [weak self] snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    print("Error fetching finished tasks:", error?.localizedDescription ?? "Unknown error")
                    return
                }
                print("Fetched finished tasks:", snapshot.documents.count)
                DispatchQueue.main.async {
                    self?.doneTaskCount = snapshot.documents.count
                }
            }
    }


    private func fetchShoppingCount() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        db.collection("users")
            .document(userId)
            .collection("shopping")
            .whereField("isPurchased", isEqualTo: false) // Only count incomplete shopping items
            .addSnapshotListener { [weak self] snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    print("Error fetching shopping total:", error?.localizedDescription ?? "Unknown error")
                    return
                }
                print("Fetched shopping items:", snapshot.documents.count)
                DispatchQueue.main.async {
                    self?.shoppingCount = snapshot.documents.count
                }
            }
    }


    private func fetchEventCount() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let today = Calendar.current.startOfDay(for: Date())
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today) ?? today
        
        let startOfDayTimestamp = Timestamp(date: today)
        let endOfDayTimestamp = Timestamp(date: tomorrow)
        print(startOfDayTimestamp)
        print(endOfDayTimestamp)
        db.collection("users")
            .document(userId)
            .collection("events")
            //.whereField("date", isGreaterThanOrEqualTo: startOfDayTimestamp)
            //.whereField("date", isLessThan: endOfDayTimestamp)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("Error fetching event total:", error.localizedDescription)
                    return
                }
                guard let snapshot = snapshot else {
                    print("Snapshot is nil.")
                    return
                }
                print("Fetched event items:", snapshot.documents.count)
                DispatchQueue.main.async {
                    self?.eventCount = snapshot.documents.count
                }
            }
    }




    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}

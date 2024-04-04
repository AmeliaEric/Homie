//
//  LoginViewViewModel.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2023-08-27.
//
import FirebaseAuth
import Foundation

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func login() {
        guard validate() else {
            return
        }
        
        //try log in
        Auth.auth().signIn(withEmail: email, password: password)
        
    }
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
                !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            errorMessage = "Please fill in all feilds"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid email."
            return false
        }
        return true
    }
}

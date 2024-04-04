//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2023-08-27.
//

import FirebaseCore
import SwiftUI

@main
struct ToDoListApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

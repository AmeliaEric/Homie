//
//  ToDoListItemDetailView.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2024-03-29.
//
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct ToDoListItemDetailView: View {
    @State private var editedTitle: String
    @State private var editedDescription: String
    @State private var editedDueDate: Date
    @State private var showingAlert = false // Add state for showing the alert
    @State private var errorMessage: String = "" // Add state for error message
    let item: ToDoListItem
    
    init(item: ToDoListItem) {
        self.item = item
        self._editedTitle = State(initialValue: item.title)
        self._editedDescription = State(initialValue: item.description)
        self._editedDueDate = State(initialValue: Date(timeIntervalSince1970: item.dueDate))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Title:")
                .font(.system(size: 16))
            TextField("Title", text: $editedTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Text("Description:")
                .font(.system(size: 16))
            TextEditor(text: $editedDescription)
                .frame(minHeight: 35, maxHeight: 100)
                .border(Color.gray, width: 0.3)
                .cornerRadius(3)
            
            DatePicker("Due Date", selection: $editedDueDate, displayedComponents: .date)
                .datePickerStyle(DefaultDatePickerStyle())
            
            VStack {
                Button("Save") {
                    saveChanges()
                }.buttonStyle(LoginPrimaryButtonStyle())
                .padding(.top)
                // Display error message if there is one
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .padding(.top, 5)
                }
            }.frame(maxWidth: .infinity)
            Spacer()
        }
        .padding()
        .navigationBarTitle("To-Do Item Details")
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Success"), message: Text("Changes saved successfully"), dismissButton: .default(Text("OK")))
        }
    }
    
    func saveChanges() {
        // Reset error message
        errorMessage = ""
        
        // Check if title is empty
        if editedTitle.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "Title cannot be empty"
            return
        }
        
        // Check if editedDueDate is valid (not in the past)
        if editedDueDate < Date() {
            errorMessage = "Due date must be in the future"
            return
        }

        // Update the item with edited title, description, and due date
        var updatedItem = item
        updatedItem.title = editedTitle
        updatedItem.description = editedDescription
        updatedItem.dueDate = editedDueDate.timeIntervalSince1970
        
        // Call a function to save the changes to the data source (Firestore)
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(updatedItem.id)
            .setData(updatedItem.asDictionary()) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated")
                    // Only show success message if there are no validation errors
                    if errorMessage.isEmpty {
                        showingAlert = true // Set showingAlert to true to show the alert
                    }
                }
            }
    }
}


struct ToDoListItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListItemDetailView(item: sampleTasks[0])
    }
}

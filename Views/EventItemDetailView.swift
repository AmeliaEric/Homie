//
//  EventItemDetailView.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2024-03-31.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct EventItemDetailView: View {
    @State private var editedTitle: String
    @State private var editedDate: Date
    @State private var editedLocation: String
    @State private var editedDescription: String
    @State private var showingAlert = false // Add state for showing the alert
    @State private var errorMessage: String = "" // Add state for error message
    let item: EventItem
    
    init(item: EventItem) {
        self.item = item
        self._editedTitle = State(initialValue: item.title)
        self._editedDate = State(initialValue: Date(timeIntervalSince1970: item.date))
        self._editedLocation = State(initialValue: item.location)
        self._editedDescription = State(initialValue: item.description)
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
            
            DatePicker("Due Date", selection: $editedDate, displayedComponents: .date)
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
        .navigationBarTitle("Event Details")
        .alert(isPresented: $showingAlert) { // Show alert when showingAlert is true
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
        
        // Check if editedDate is valid (not in the past)
        if editedDate < Date() {
            errorMessage = "Date must be in the future"
            return
        }

        // Update the event with edited details
        var updatedItem = item
        updatedItem.title = editedTitle
        updatedItem.date = editedDate.timeIntervalSince1970
        updatedItem.location = editedLocation
        updatedItem.description = editedDescription
        
        // Get a reference to the Firestore database
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        // Update the document in Firestore
        db.collection("users")
            .document(uid)
            .collection("events")
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

struct EventItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let isDetailViewPresented = Binding.constant(true)
        return EventItemDetailView(item: sampleEvents[0])
    }
}

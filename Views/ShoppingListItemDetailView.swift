//
//  ShoppingListItemDetailView.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2024-03-30.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct ShoppingListItemDetailView: View {
    @State private var editedName: String
    @State private var editedQuantity: String // Change type to String
    @State private var editedPBrand: String
    @State private var editedPStore: String
    @State private var showingAlert = false // Add state for showing the alert
    @State private var errorMessage: String = "" // Add state for error message
    let item: ShoppingListItem
    let itemId: String // Add itemId property to hold the item's ID
    
    init(item: ShoppingListItem) {
        self.item = item
        self.itemId = item.id // Assign item's ID
        self._editedName = State(initialValue: item.name)
        self._editedQuantity = State(initialValue: String(item.quantity))
        self._editedPBrand = State(initialValue: item.preferredBrand ?? "")
        self._editedPStore = State(initialValue: item.preferredStore ?? "")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name:")
                .font(.system(size: 16))
            TextField("Name", text: $editedName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Text("Quantity:") // Correct placeholder text
                .font(.system(size: 16))
            TextField("Quantity", text: $editedQuantity)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Use RoundedBorderTextFieldStyle for consistency
            Text("Preferred Brand:")
                .font(.system(size: 16))
            TextField("Preferred Brand", text: $editedPBrand)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Text("Preferred Store:")
                .font(.system(size: 16))
            TextField("Preferred Store", text: $editedPStore)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
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
        .navigationBarTitle("Shopping Item Details")
        .alert(isPresented: $showingAlert) { // Show alert when showingAlert is true
            Alert(title: Text("Success"), message: Text("Changes saved successfully"), dismissButton: .default(Text("OK")))
        }
    }
    
    func saveChanges() {
        // Reset error message
        errorMessage = ""
        
        // Check if name is empty
        if editedName.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "Name cannot be empty"
            return
        }
        
        // Check if quantity is empty or not a valid integer
        if editedQuantity.trimmingCharacters(in: .whitespaces).isEmpty || Int(editedQuantity) == nil {
            errorMessage = "Quantity must be a valid number"
            return
        }

        // Update the item with edited values
        var updatedItem = item
        updatedItem.name = editedName
        updatedItem.quantity = Int(editedQuantity) ?? 0 // Convert String to Int
        updatedItem.preferredBrand = editedPBrand
        updatedItem.preferredStore = editedPStore
        
        // Call a function to save the changes to the data source (Firestore)
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.collection("users")
            .document(uid)
            .collection("shopping")
            .document(itemId) // Use itemId to update the correct document
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
struct ShoppingListItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListItemDetailView(item: sampleShoppingItems[0])
    }
}

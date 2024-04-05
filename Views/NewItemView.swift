//
//  NewItemView.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2023-08-27.
//

import SwiftUI

struct NewItemView: View {
    @StateObject var viewModel = NewItemViewViewModel()
    @State private var selectedFamilyMemberIndex = 0
    @Binding var newItemPresented: Bool
    var familyMembers: [User]
    
    var body: some View {
        VStack {
            Text("New Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 100)
            
            Form {
                // Title
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                // Due Date
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                // Description
                TextField("Description", text: $viewModel.description)
                    .textFieldStyle(DefaultTextFieldStyle())
                // Dropdown for assigning task to a family member
                Picker("Assign To", selection: $selectedFamilyMemberIndex) {
                    ForEach(0..<familyMembers.count) { index in
                        Text(familyMembers[index].name).tag(index)
                    }
                }
                // Button
                Button(action: {
                    if viewModel.canSave {
                        viewModel.save()
                        newItemPresented = false
                    } else{
                        viewModel.showAlert = true
                    }
                }) {
                    Text("Save")
                }.buttonStyle(LoginPrimaryButtonStyle())
                .padding()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text("Please fill in all fields and select due date that is today or newer."))
            }
        }
    }
}

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView(newItemPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }), familyMembers: []) // Provide an empty array or mock data for familyMembers
    }
}

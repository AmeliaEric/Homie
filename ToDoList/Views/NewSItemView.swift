//
//  NewSItemView.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2024-03-01.
//
import SwiftUI

struct NewShoppingItemView: View {
    @StateObject var viewModel = NewShoppingItemViewViewModel()
    @Binding var newItemPresented: Bool
    
    var body: some View {
        VStack {
            Text("New Shopping Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 100)
            
            Form {
                // Name
                TextField("Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                // Quantity
                TextField("Quantity", text: $viewModel.quantity)
                    .keyboardType(.numberPad)
                    .textFieldStyle(DefaultTextFieldStyle())
                // Preferred Brand
                TextField("Preferred Brand (optional)", text: $viewModel.preferredBrand)
                    .textFieldStyle(DefaultTextFieldStyle())
                // Preferred Store
                TextField("Preferred Store (optional)", text: $viewModel.preferredStore)
                    .textFieldStyle(DefaultTextFieldStyle())
                // Button
                Button("Save")
                {
                    if viewModel.canSave {
                        viewModel.save()
                        newItemPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }.buttonStyle(LoginPrimaryButtonStyle())
                .padding()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text("Please fill in all required fields and ensure quantity is a valid number."))
            }
        }
    }
}

struct NewShoppingItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewShoppingItemView(newItemPresented: Binding.constant(true))
    }
}

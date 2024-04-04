//
//  EventCreationView.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2024-03-11.
//

import SwiftUI

struct EventCreationView: View {
    @StateObject var viewModel = NewEventItemViewViewModel()
    @Binding var newItemPresented: Bool
        var body: some View {
            VStack {
                Text("New Event")
                    .font(.system(size: 32))
                    .bold()
                    .padding(.top, 100)
                
                Form {
                    Section(header: Text("Event Details")) {
                        TextField("Title", text: $viewModel.title)
                        DatePicker("Date", selection: $viewModel.date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                        TextField("Location", text: $viewModel.location)
                        TextField("Description", text: $viewModel.description)
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
}

struct EventCreationView_Previews: PreviewProvider {
    static var previews: some View {
        EventCreationView(newItemPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }))
    }
}

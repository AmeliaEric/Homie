//
//  RegisterView.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2023-08-27.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    
    var body: some View {
        VStack {
            // Header
            HeaderView(title: "Register",
                       subtitle: "Start Organizing Your Family!",
                       background: Color("AccentColor"))
            
            Form{
                TextField("Full Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                HStack {
                    Spacer()
                                        
                    Button(action: {
                        viewModel.register()
                    }) {
                        Text("Register")
                    }.buttonStyle(LoginPrimaryButtonStyle())
                                        
                    Spacer()
                }
            }
            .offset(y: -50)
            
            Spacer()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

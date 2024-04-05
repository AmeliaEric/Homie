//
//  LoginView.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2023-08-27.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView(title: "Welcome to Homie!",
                            subtitle: "Get Things Done",
                            background: Color("AccentColor"))
                
                Form{
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    HStack {
                        Spacer()
                                            
                        Button(action: {
                            viewModel.login()
                        }) {
                            Text("Login")
                        }.buttonStyle(LoginPrimaryButtonStyle())
                                            
                        Spacer()
                    }
                    
                    
                }
                .offset(y: -50)
                
                //Create Account
                VStack{
                    Text("New Around Here?")
                    NavigationLink("Create An Account",
                                   destination: RegisterView())
                }
                .padding(.bottom, 50)
                
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

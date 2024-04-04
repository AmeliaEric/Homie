//
//  ProfileView.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2023-08-27.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    @State private var isEditing = false
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                    
                } else {
                    Text ("Loading Profile...")
                }
            }
            .navigationTitle("Profile")
//            .navigationBarItems(trailing:
//                            Button(action: {
//                                isEditing = true
//                            }) {
//                                Text("Edit Profile")
//                            }
//                        )
//                        .sheet(isPresented: $isEditing) {
//                            //EditProfileView(user: viewModel.user ?? User())
//                        }
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
    
    @ViewBuilder
    func profile(user: User) -> some View {
        //avatar
        Image(decorative: "Profile")
            .resizable()
            .frame(width: 100, height: 100)
            .padding()
        //info: name, email, member since
        VStack(alignment: .leading) {
            HStack{
                Text("Name: ")
                    .bold()
                Text(user.name)
            }
            HStack{
                Text("Email: ")
                    .bold()
                Text(user.email)
            }
            HStack{
                Text("Member Since: ")
                    .bold()
                Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
            }
//            HStack{
//                Text("Age: ")
//                    .bold()
//                    if let age = user.age {
//                        Text(String(age))
//                    } else {
//                        Text("Unknown")
//                    }
//            }
//            HStack{
//                Text("Likes: ")
//                    .bold()
//                    if let likes = user.likes {
//                        Text(likes.joined(separator: ", "))
//                    } else {
//                        Text("No likes")
//                    }
//            }
//            HStack{
//                Text("Dislikes: ")
//                    .bold()
//                    if let dislikes = user.dislikes {
//                        Text(dislikes.joined(separator: ", "))
//                    } else {
//                        Text("No dislikes")
//                    }
//            }
//            HStack{
//                Text("Allergies: ")
//                        .bold()
//                    if let allergies = user.allergies {
//                        Text(allergies.joined(separator: ", "))
//                    } else {
//                        Text("No allergies")
//                    }
//            }
//            HStack{
//                Text("Medical Information: ")
//                        .bold()
//                    if let medinfo = user.medicalInformation {
//                        Text(medinfo)
//                    } else {
//                        Text("No medical information provided")
//                    }
//            }
//            HStack{
//                Text("Family Code: ")
//                    .bold()
//                Text(String(user.familyGroupNumber))
//            }
        }
        .padding()
        //signout
        Button("Log Out")
        {
            viewModel.logOut()
        }.buttonStyle(SmallPrimaryButtonStyle())
        .padding()

        Spacer()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

//
//  ContentView.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2023-08-27.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    @State private var tabSelection: Tab = .house
    @State private var isHomePageSelected = false // Add this line
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            ZStack {
                VStack {
                    // Greeting message
                    if isHomePageSelected && tabSelection == .house { // Show only if homepage button is clicked and house tab is selected
                        if let currentUser = viewModel.user {
                            Text("Hi, \(currentUser.name)!")
                                .font(.title)
                                .padding()
                                .titleStyle()
                                .foregroundColor(Color("SecondTitle"))
                            Text("Let’s make this day productive")
                                .font(.subheadline)
                                .padding()
                                .subtitleStyle()
                            
                        }
                    }

//                    // Icons for family members
//                    if isHomePageSelected && tabSelection == .house { // Show only if homepage button is clicked and house tab is selected
//                        if let currentUser = viewModel.user {
//                            // Icons for family members
//                            ScrollView(.horizontal, showsIndicators: false) {
//                                HStack(spacing: 20) {
//                                    ForEach(viewModel.familyMembers, id: \.id) { familyMember in
//                                        // Display icons or names of family members here
//                                            Text(familyMember.name)
//                                        }
//                                }.padding()
//                            }
//                        }
//                    }

                    // Show number of tasks and events
                    if isHomePageSelected && tabSelection == .house { // Show only if homepage button is clicked and house tab is selected
                        HStack {
                            VStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("AccentColor"))
                                        .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 2, y: 2) // Add shadow
                                    
                                    VStack {
                                        Text("\(viewModel.taskCount)")
                                            .font(.headline)
                                            .foregroundColor(Color.white)
                                        Text("Tasks")
                                            .font(.subheadline)
                                            .foregroundColor(Color.white)
                                            .padding(.top, 4) // Adjust as needed
                                    }
                                    //.padding()
                                }
                                .padding()
                                
                                //Spacer()
                            }
                            VStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color("AccentColor"))
                                        .shadow(color: Color.gray.opacity(0.7), radius: 5, x: 2, y: 2) // Add shadow
                                    
                                    VStack {
                                        Text("\(viewModel.doneTaskCount)")
                                            .font(.headline)
                                            .foregroundColor(Color.white)
                                        Text("Finished Tasks")
                                            .font(.subheadline)
                                            .foregroundColor(Color.white)
                                            .padding(.top, 4) // Adjust as needed
                                    }
                                    .padding()
                                }
                                .padding()
                                
                                //Spacer()
                            }
                        }//.padding()
                        Spacer()
                        HStack{
                            VStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("AccentColor"))
                                        .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 2, y: 2) // Add shadow
                                    
                                    VStack {
                                        Text("\(viewModel.eventCount)")
                                            .font(.headline)
                                            .foregroundColor(Color.white)
                                        Text("Events")
                                            .font(.subheadline)
                                            .foregroundColor(Color.white)
                                            .padding(.top, 4) // Adjust as needed
                                    }
                                    //.padding()
                                }
                                .padding()
                                
                                Spacer()
                            }
                            VStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("AccentColor"))
                                        .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 2, y: 2) // Add shadow
                                    
                                    VStack {
                                        Text("\(viewModel.shoppingCount)")
                                            .font(.headline)
                                            .foregroundColor(Color.white)
                                        Text("Shopping Items")
                                            .font(.subheadline)
                                            .foregroundColor(Color.white)
                                            .padding(.top, 4) // Adjust as needed
                                    }
                                    .padding()
                                }
                                .padding()
                                
                                Spacer()
                            }
                        }
                    }
                    // Conditional content based on tab selection
                    switch tabSelection {
                        case .listBulletClipboard:
                            ToDoListView(userId: viewModel.currentUserId)
                        case .cart:
                            ShoppingListView(userId: viewModel.currentUserId)
                        case .house:
                            Text(" ")
                        case .folder:
                            EventListView(userId: viewModel.currentUserId)
                        case .person:
                            ProfileView()
                    }
                    
                    // Custom tab view
                    CustomTabView(tabSelection: $tabSelection)
                }
            }
            .onAppear {
                isHomePageSelected = true // Set to true when the view appears
            }
        } else {
            LoginView()
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

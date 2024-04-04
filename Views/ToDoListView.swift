//
//  ToDoListItemsView.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2023-08-27.
//
import FirebaseFirestoreSwift
import SwiftUI

struct ToDoListView: View {
    @StateObject var viewModel: ToDoListViewViewModel
    @FirestoreQuery var items: [ToDoListItem]
    
    init(userId: String) {
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos"
        )
        self._viewModel = StateObject(
            wrappedValue: ToDoListViewViewModel(userId: userId)
        )
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if items.isEmpty {
                    Image(decorative: "No Item")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    Text("You don’t have any tasks yet. \nTap the plus button to create new to-do task.")
                        .captionStyle()
                } else {
                    List(items.sorted(by: { $0.dueDate < $1.dueDate })) { item in // Sorting by due date
                        NavigationLink(destination: ToDoListItemDetailView(item: item)) {
                            ToDoListItemView(item: item)
                                .swipeActions {
                                    Button("Delete") {
                                        viewModel.delete(id: item.id)
                                    }
                                    .tint(.red)
                                }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationBarTitle("To-Do List")
            .navigationBarTitleStyle()
            .toolbar {
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundColor(Color("AccentColor"))
                        .frame(width: 30, height: 30)
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresented: $viewModel.showingNewItemView, familyMembers: [])
            }
        }
    }
}

struct ToDoListItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(userId: "yxnQ6iEu7QcsVGm55y4uXifJG6F2")
    }
}

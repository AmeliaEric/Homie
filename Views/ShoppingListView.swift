//
//  ShoppingListView.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2024-03-01.
//

import FirebaseFirestoreSwift
import SwiftUI

struct ShoppingListView: View {
    @StateObject var viewModel: ShoppingListViewViewModel
    @FirestoreQuery var items: [ShoppingListItem]
    
    init(userId: String) {
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/shopping"
        )
        self._viewModel = StateObject(
            wrappedValue: ShoppingListViewViewModel(userId: userId)
        )
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if items.isEmpty {
                    Image(decorative: "No Shopping")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    Text("You don’t have any shopping items yet. \nTap the plus button to create new item for your list.")
                        .captionStyle()
                } else {
                    List(items.sorted(by: { $0.name < $1.name })) { item in // Sorting by the first letter of the name
                        NavigationLink(destination:
                            ShoppingListItemDetailView(item: item)) {
                            ShoppingListItemView(item: item)
                                .swipeActions {
                                    Button("Delete"){
                                        viewModel.delete(id: item.id)
                                    }
                                    .tint(.red)
                                    
                                }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                
            }
            .navigationBarTitle("Shopping List")
            .navigationBarTitleStyle()
            .toolbar {
                Button {
                    viewModel.showingNewShoppingItemView = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundColor(Color("AccentColor"))
                        .frame(width: 30, height: 30)
                }
            }
            .sheet(isPresented: $viewModel.showingNewShoppingItemView) {
                NewShoppingItemView(newItemPresented: $viewModel.showingNewShoppingItemView)
            }
        }
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView(userId: "yxnQ6iEu7QcsVGm55y4uXifJG6F2")
    }
}

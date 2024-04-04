//
//  ShoppingListItemView.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2024-03-01.
//

import SwiftUI

struct ShoppingListItemView: View {
    @StateObject var viewModel = ShoppingListItemViewViewModel()
    let item: ShoppingListItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.body)
                Text("Quantity: " + String(item.quantity))
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            
            Spacer()
            
            Button(action: {
                viewModel.toggleIsPurchased(item: item)
            }) {
                Image(systemName: item.isPurchased ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color("AccentColor"))
                    .font(.system(size: 20))
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
    }
}

struct ShoppingListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListItemView(item: .init(id: "123", name: "Get milk", quantity: 3, isPurchased: false, preferredBrand: nil, preferredStore: nil, createDate: Date().timeIntervalSince1970))
    }
}

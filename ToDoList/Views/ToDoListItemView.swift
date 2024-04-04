//
//  ToDoListItemView.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2023-08-27.
//

import SwiftUI

struct ToDoListItemView: View {
    @StateObject var viewModel = ToDoListItemViewViewModel()
    let item: ToDoListItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.body)
                Label("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))", systemImage: "clock")
                    .captionStyle()
                    .foregroundColor(Color(.secondaryLabel))
            }
            
            Spacer()
            
            Button(action: {
                viewModel.toggleIsDone(item: item)
            }) {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color("AccentColor"))
                    .font(.system(size: 20))
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
    }
}


struct ToDoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListItemView(item: .init(id: "123",
                                     title: "Testing milk",
                                     description: "Buy a gallon of milk from the grocery store",
                                     dueDate: Date().timeIntervalSince1970,
                                     createDate: Date().timeIntervalSince1970,
                                     isDone: false))
    }
}

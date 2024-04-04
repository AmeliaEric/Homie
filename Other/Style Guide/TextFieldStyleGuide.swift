//
//  TextFieldStyleGuide.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2024-03-10.
//

import SwiftUI

struct TextFieldStyleGuide: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, World!")
            TextField("", text: .constant("text style"))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("", text: .constant("text style"))
                .textFieldStyle(UnderlineTextFieldStyle())
        }
        .padding()
    }
}

struct UnderlineTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: "person") // Replace "person" with your icon name
                    .foregroundColor(.black) // Customize icon color
                    .padding(.trailing, 8) // Adjust spacing between icon and text
                configuration
                    .padding(0)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                    .background(Color.white)
            }
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.black) // Change the color of the underline here
        }
    }
}

struct TextFieldStyleGuide_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldStyleGuide()
    }
}

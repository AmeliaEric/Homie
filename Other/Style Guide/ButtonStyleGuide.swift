//
//  ButtonStyleGuide.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2024-03-09.
//

import SwiftUI

struct ButtonStyleGuide: View {
    var body: some View {
        VStack(spacing: 30) {
        Text("Button Styles")
            
            Button {
                
            } label: {
                Text("Save")

            }.buttonStyle((SmallPrimaryButtonStyle()))
            Button {
                
            } label: {
                Text("Cancel")

            }.buttonStyle((SmallSecondaryButtonStyle()))
            
            Button {
                
            } label: {
                Text("Login")

            }.buttonStyle((LoginPrimaryButtonStyle()))
        }
    }
}

struct SmallPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .bodyStyle()
            .foregroundColor(Color.white)
            .padding(.vertical, 15)
            .padding(.horizontal, 35)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color("AccentColor")))
    }
}

struct SmallSecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .bodyStyle()
            .foregroundColor(Color("AccentColor")) // Set text color to AccentColor
            .padding(.vertical, 15)
            .padding(.horizontal, 30)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.white) // Set button background to white
                    .overlay( // Overlay a border on top of the background
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("AccentColor"), lineWidth: 2) // Set border color and width
                    )
            )
    }
}

struct LoginPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .bodyStyle()
            .foregroundColor(Color.white)
            .padding(.vertical, 15)
            .padding(.horizontal, 115)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color("AccentColor")))
    }
}

struct ButtonStyleGuide_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyleGuide()
    }
}

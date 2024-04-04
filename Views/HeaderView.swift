//
//  HeaderView.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2023-08-27.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    let background: Color
    
    var body: some View {
        ZStack {
            background
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text(title)
                    .titleStyle()
                    .padding(.top, 50)
                    .foregroundColor(Color.white)
                
                Text(subtitle)
                    .subtitleStyle()
                    .foregroundColor(.white)
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: 250)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Title",
                   subtitle: "Subtitle",
                   background: .blue)
    }
}

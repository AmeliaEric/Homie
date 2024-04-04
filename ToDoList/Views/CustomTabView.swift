//
//  CustomTabView.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2024-03-12.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case listBulletClipboard = "list.bullet.clipboard"
    case cart
    case house = "house.circle.fill"
    case folder
    case person
}


struct CustomTabView: View {
    @Binding var tabSelection: Tab
    private var fillImage: String {
        if tabSelection == .house {
            return tabSelection.rawValue
        } else {
            return tabSelection.rawValue + ".fill"
        }
    }
    
    var body: some View {
        ZStack {
            Capsule()
                .frame(height: 80)
                .foregroundColor(Color.white)
                .shadow(color: Color("ButtonShadowColor"), radius: 20, x: 8, y: 11)
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) {tab in
                    Spacer()
                    Image(systemName: tabSelection == tab ? fillImage : tab.rawValue)
                        .scaleEffect(tabSelection == tab ? 1.25 : 1.0)
                        .foregroundColor(tabSelection == tab ? .accentColor : .gray)
                        .font(.system(size: tab == .house ? 55 : 25))
                        .onTapGesture{
                            withAnimation(.easeIn(duration: 0.1)) {
                                tabSelection = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(height: 80)
        }
        .padding(.horizontal)
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView(tabSelection: .constant(.house))
            .previewLayout(.sizeThatFits)
            .padding(.vertical)
    }
}

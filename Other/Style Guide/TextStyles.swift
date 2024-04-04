//
//  TextStyles.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2024-03-09.
//

import SwiftUI

struct TextStyles: View {
    var body: some View {
        VStack {
            Text("Title")
                .titleStyle()
            Text("Subtitle")
                .subtitleStyle()
            Text("Body")
                .bodyStyle()
            Text("Caption")
                .captionStyle()
            Text("Caption")
                .navigationBarTitleStyle()
        }
    }
}


extension View {
    public func titleStyle() -> some View {
        modifier(TitleStyle())
    }
    public func subtitleStyle() -> some View {
        modifier(SubtitleStyle())
    }
    public func bodyStyle() -> some View {
        modifier(BodyStyle())
    }
    public func captionStyle() -> some View {
        modifier(CaptionStyle())
    }
    public func navigationBarTitleStyle() -> some View {
        self.modifier(NavigationBarTitleStyle())
    }
}

struct NavigationBarTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Hevetica", size: 36, relativeTo: .title))
            .foregroundColor(Color("SecondTitle"))
    }
}


struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Hevetica", size: 36, relativeTo: .title))
    }
}
struct SubtitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Hevetica", size: 24, relativeTo: .title2))
    }
}

struct BodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Hevetica", size: 16, relativeTo: .body))
    }
}

struct CaptionStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Hevetica", size: 14, relativeTo: .caption))
    }
}

struct TextStyles_Previews: PreviewProvider {
    static var previews: some View {
        TextStyles()
    }
}

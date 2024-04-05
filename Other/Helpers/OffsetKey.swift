//
//  OffsetKey.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2024-03-13.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

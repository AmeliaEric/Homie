//
//  Extension.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2023-08-27.
//

import Foundation

extension Encodable {
    func asDictionary () -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}

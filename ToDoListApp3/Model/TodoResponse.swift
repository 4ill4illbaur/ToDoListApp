//
//  TofoResponse.swift
//  ToDoListApp3
//
//  Created by Бауржан Еркен on 27.08.2024.
//

import Foundation

struct TodoResponse: Codable {
    let todos: [Todo]
}

struct Todo: Codable {
    let id: Int
    let todo: String
    let completed: Bool
}

//
//  NetworkManager.swift
//  ToDoListApp3
//
//  Created by Бауржан Еркен on 27.08.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    private let baseURL = "https://dummyjson.com/todos"

    private init() {}

    func fetchTodos(completion: @escaping ([Todo]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: self.baseURL) else {
                print("Invalid URL")
                return
            }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error fetching todos: \(error)")
                    return
                }

                guard let data = data else {
                    print("No data")
                    return
                }

                do {
                    let todoResponse = try JSONDecoder().decode(TodoResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(todoResponse.todos)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }

            task.resume()
        }
    }
}

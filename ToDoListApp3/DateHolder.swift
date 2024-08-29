//
//  DateHolder.swift
//  ToDoListApp3
//
//  Created by Бауржан Еркен on 27.08.2024.
//

import SwiftUI
import CoreData

class DateHolder: ObservableObject {
    private let context: NSManagedObjectContext

    init(_ context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func loadTodosFromAPI() {
        NetworkManager.shared.fetchTodos { todos in
            DispatchQueue.global(qos: .background).async {
                self.saveTodos(todos: todos)
            }
        }
    }
    
    private func saveTodos(todos: [Todo]) {
        let fetchRequest: NSFetchRequest<TaskItem> = TaskItem.fetchRequest()
        do {
            let existingTasks = try context.fetch(fetchRequest)
            let existingIds = Set(existingTasks.map { $0.id })
            
            for todo in todos {
                if !existingIds.contains(Int64(todo.id)) {
                    let newTask = TaskItem(context: context)
                    newTask.id = Int64(todo.id)
                    newTask.name = todo.todo
                    newTask.todo = todo.todo
                    newTask.completed = todo.completed
                    newTask.createdAt = Date()
                    newTask.dueDate = nil
                    newTask.scheduleTime = false
                }
            }
            
            DispatchQueue.main.async {
                self.saveContext()
            }
        } catch {
            print("Failed to fetch existing tasks: \(error)")
        }
    }
}

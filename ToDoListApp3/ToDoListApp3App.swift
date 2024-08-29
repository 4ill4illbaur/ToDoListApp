//
//  ToDoListApp3App.swift
//  ToDoListApp3
//
//  Created by Бауржан Еркен on 27.08.2024.
//

import SwiftUI

@main
struct ToDoListApp3App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TaskListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(DateHolder(persistenceController.container.viewContext))
                .onAppear {
                    
                    DateHolder(persistenceController.container.viewContext).loadTodosFromAPI()
                }
        }
    }
}


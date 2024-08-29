//
//  CheckBoxView.swift
//  ToDoListApp3
//
//  Created by Бауржан Еркен on 27.08.2024.
//

import SwiftUI

struct CheckBoxView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedTaskItem: TaskItem

    var body: some View {
        Image(systemName: passedTaskItem.isCompleted() ? "checkmark.circle.fill" : "circle")
            .foregroundColor(passedTaskItem.isCompleted() ? .green : .secondary)
            .onTapGesture {
                withAnimation {
                    if !passedTaskItem.isCompleted() {
                        passedTaskItem.completed = true
                        dateHolder.saveContext()
                    }
                }
            }
    }
}

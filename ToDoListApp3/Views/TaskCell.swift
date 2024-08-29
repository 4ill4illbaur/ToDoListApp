//
//  TaskCell.swift
//  ToDoListApp3
//
//  Created by Бауржан Еркен on 27.08.2024.
//

import SwiftUI

struct TaskCell: View {
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedTaskItem: TaskItem
    
    var body: some View {
        CheckBoxView(passedTaskItem: passedTaskItem)
            .environmentObject(dateHolder)
        
        Text(passedTaskItem.todo ?? "")
            .padding(.horizontal)
    }
}

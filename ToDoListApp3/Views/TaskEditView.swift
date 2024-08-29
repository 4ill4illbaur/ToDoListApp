//
//  TaskEditView.swift
//  ToDoListApp3
//
//  Created by Бауржан Еркен on 27.08.2024.
//

import SwiftUI

struct TaskEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    
    @State private var name: String
    @State private var desc: String
    @State private var dueDate: Date
    @State private var scheduleTime: Bool
    
    private var selectedTaskItem: TaskItem?

    init(passedTaskItem: TaskItem?, initialDate: Date) {
        _name = State(initialValue: passedTaskItem?.name ?? "")
        _desc = State(initialValue: passedTaskItem?.todo ?? "")
        _dueDate = State(initialValue: passedTaskItem?.dueDate ?? initialDate)
        _scheduleTime = State(initialValue: passedTaskItem?.scheduleTime ?? false)
        self.selectedTaskItem = passedTaskItem
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Task")
                        .font(.headline)
                    
                    TextField("Task Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Description", text: $desc)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                
                // Due Date Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Due Date")
                        .font(.headline)
                    
                    Toggle("Schedule Time", isOn: $scheduleTime)
                    
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: displayComps())
                        .datePickerStyle(GraphicalDatePickerStyle())
                }
                .padding()
                
             
                if selectedTaskItem?.completed == true {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Completed")
                            .font(.headline)
                        

                    }
                    .padding()
                }
                
                Spacer()
                
                // Save Button
                Button(action: saveAction) {
                    Text("Save")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            //.navigationTitle(selectedTaskItem == nil ? "New Task" : "Edit Task")
        }
    }
    
    private func displayComps() -> DatePickerComponents {
        return scheduleTime ? [.hourAndMinute, .date] : [.date]
    }
    
    private func saveAction() {
        withAnimation {
            let taskItem: TaskItem
            if let existingTaskItem = selectedTaskItem {
                taskItem = existingTaskItem
            } else {
                taskItem = TaskItem(context: viewContext)
                taskItem.id = Int64(Date().timeIntervalSince1970)
            }
            
            taskItem.createdAt = Date()
            taskItem.name = name
            taskItem.todo = desc
            taskItem.dueDate = dueDate
            taskItem.scheduleTime = scheduleTime
            taskItem.completed = false
            
            dateHolder.saveContext()
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

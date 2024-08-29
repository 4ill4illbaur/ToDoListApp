//
//  FloatingButton.swift
//  ToDoListApp3
//
//  Created by Бауржан Еркен on 27.08.2024.
//

import SwiftUI

struct FloatinButton: View {
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View {
        Spacer()
        HStack {
            NavigationLink(destination: TaskEditView(passedTaskItem: nil, initialDate: Date()).environmentObject(dateHolder)) {
                Text("+ New Task")
                    .font(.headline)
            }
            .padding(15)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(25)
            .padding(30)
            .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3 )
        }
    }
}

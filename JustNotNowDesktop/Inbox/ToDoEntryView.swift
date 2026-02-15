//  ToDoEntryView.swift
//  JustNotNowDesktop

import SwiftUI

struct ToDoEntryView: View {
    
    @Environment(ToDoRepository.self) var repository
    @Environment(\.dismiss) var dismiss
    
    @State private var item = ToDoItem(
        itemDescription: "test",
        note: "note",
        priority: 1,
        reminderDate: nil,
        isCompleted: false
    )
    
    var body: some View {
            VStack {
                TaskInfoSection(item: $item)
                PrioritySection(item: $item)
                SymbolSection(item: $item)
                ReminderSection(item: $item)
                Spacer()
            }
        .navigationTitle("New To-Do")
    }
}

#Preview {
    NavigationStack {
        ToDoEntryView()
    }
}

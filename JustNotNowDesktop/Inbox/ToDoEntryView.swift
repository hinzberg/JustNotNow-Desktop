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
                
                HStack {
                    Spacer()
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.title2)
                            .frame(width: 70)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    
                    Button(role: .confirm) {
                        repository.add(item)
                        dismiss()
                    } label: {
                        Text("Save")
                            .font(.title2)
                            .frame(width: 70)
                    }
                    .buttonStyle(.borderedProminent)
                }
                Spacer()
            }
            .padding()
        .navigationTitle("New To-Do")
    }
}

#Preview {
    NavigationStack {
        ToDoEntryView()
    }
}

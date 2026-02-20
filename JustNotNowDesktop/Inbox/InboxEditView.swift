//  ToDoEntryView.swift
//  JustNotNowDesktop

import SwiftUI

struct InboxEditView: View {
    
    @Environment(ToDoRepository.self) var repository
    @Environment(\.dismiss) var dismiss

    @State var item : ToDoItem
    @State private var isExistingItem: Bool = false
    
    var body: some View {
            VStack {
                TaskInfoSection(item: $item)
                // PrioritySection(item: $item)
                SymbolSection(item: $item)
                ReminderSection(item: $item)
                
                HStack {
                    Button(role: .confirm) {
                        repository.moveToBacklog(item)
                        dismiss()
                    } label: {
                        Text("Move to Backlog")
                            .font(.title2)
                            .frame(width: 140)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                    
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
                        repository.addOrUpdate(item)
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
            .onAppear {
                isExistingItem = repository.sortedByPriority().contains { $0.id == item.id }
            }
            .navigationTitle(isExistingItem ? "Edit ToDo" : "Add New ToDo" )
    }
}

#Preview {
    NavigationStack {
        InboxEditView(item: .sample())
    }
}

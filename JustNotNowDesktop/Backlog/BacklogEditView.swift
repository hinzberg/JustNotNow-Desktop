//  BacklogEditView.swift
//  JustNotNowDesktop
//  Created by Holger Hinzberg on 20.02.26.

import SwiftUI

struct BacklogEditView: View {
    
    @Environment(ToDoRepository.self) var repository
    @Environment(\.dismiss) var dismiss
    
    @State var item : ToDoItem
    @State private var showUpNextLimitAlert = false
    
    var body: some View {
        VStack {
            TaskInfoSection(item: $item)
            // PrioritySection(item: $item)
            SymbolSection(item: $item)
            ReminderSection(item: $item)
            
            HStack {
                Button(role: .confirm) {
                    if repository.upNextItemsCount >= AppSettings.shared.MaxItemsUpNext {
                        showUpNextLimitAlert = true
                    } else {
                        repository.moveToUpNext(item)
                        dismiss()
                    }
                } label: {
                    Text("Move to Up Next")
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
        .navigationTitle("Edit Backlog ToDo")
        .alert("Too many items in Up Next", isPresented: $showUpNextLimitAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("There are already too many items in Up Next.")
        }
    }
}

#Preview {
    NavigationStack {
        BacklogEditView(item: .sample())
    }
}

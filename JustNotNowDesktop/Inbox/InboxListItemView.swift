//  ToDoItemView.swift
//  JustNotNow
//  Created by Holger Hinzberg on 19.04.25.

import SwiftUI

struct InboxListItemView: View {
    
    @Environment(ToDoRepository.self) var repository
    let item: ToDoItem
    
    var body: some View {
        HStack {
            
            // MARK: Colored rectangle based on priority
            Rectangle()
                .fill(priorityColor(for: item))
                .frame(width: 10)
                .cornerRadius(5)
                .padding(EdgeInsets(top: 0, leading: 0 , bottom: 0, trailing: 10))
            
            Image(systemName: item.imageName)
                .foregroundColor(item.isCompleted ? .secondary : .primary)
                .font(.system(size: 25))
                .frame(width: 30)
                .padding(EdgeInsets(top: 0, leading: 0 , bottom: 0, trailing: 10))
            
            VStack(alignment: .leading) {
                Text(item.itemDescription)
                    .font(.headline)
                    .foregroundColor(item.isCompleted ? .secondary : .primary)
                
                Text("Priority: \(item.priority)")
                    .font(.subheadline)
                    .foregroundColor(item.isCompleted ? .secondary : .primary)
            }
            Spacer()
            
            if let date = item.reminderDate {
                Image(systemName: "clock")
                    .foregroundColor(item.isCompleted ? .secondary : .primary)
                    .font(.system(size: 16))
                    .padding(.trailing, 10)
                    .help(date.formatted(date: .abbreviated, time: .shortened))
            }
        }
        .frame(maxWidth: .infinity)  // Ensure the HStack takes up the full width
        .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
        .listRowInsets(EdgeInsets())
        .frame( maxWidth: .infinity)
        
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                repository.toggleCompletion(item)
            } label: {
                Label(item.isCompleted ? "Uncomplete" : "Complete",
                      systemImage: item.isCompleted ? "arrow.uturn.backward.circle" : "checkmark.circle")
            }
            .tint(item.isCompleted ? .orange : .green)
        }
        
    }
    
    // Helper function to return a red→green gradient color based on priority (1..6)
    private func priorityColor(for item: ToDoItem) -> Color {
        
        if item.isCompleted {
            return .secondary
        }
        
        // Only 1...6 are valid; everything else is gray
        guard (1...6).contains(item.priority) else {
            return .gray
        }
        
        let clamped = item.priority
        
        // Map 1 → red, 6 → green with a smooth gradient in between
        let t = Double(clamped - 1) / 5.0     // 0.0 ... 1.0
        let red   = 1.0 - t                   // 1 → 0
        let green = t                         // 0 → 1
        
        return Color(red: red, green: green, blue: 0.0)
    }
    
}

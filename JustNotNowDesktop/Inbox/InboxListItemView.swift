//  ToDoItemListView.swift
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
                .fill(Colors.priorityColor(for: item))
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
                    .font(.title2)
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
        .frame(minHeight: 40)
   }
}

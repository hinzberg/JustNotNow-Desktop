//  ToDoItem.swift
//  JustNotNow
//  Created by Holger Hinzberg on 19.04.25.

import Foundation

struct ToDoItem: Identifiable, Hashable {
    let id = UUID()
    var itemDescription: String
    var note: String = ""
    var imageName: String = "star"
    var priority: Int
    var reminderDate: Date?
    var isCompleted: Bool = false
    
    var IsIvyLee: Bool {
        (1...6).contains(priority)
    }
    
    func matchesFilter(_ filter: String) -> Bool {
            let lowercasedFilter = filter.lowercased()
            return itemDescription.lowercased().contains(lowercasedFilter) ||
                   note.lowercased().contains(lowercasedFilter)
        }
}

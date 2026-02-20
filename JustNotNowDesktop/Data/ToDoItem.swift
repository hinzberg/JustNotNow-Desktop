//  ToDoItem.swift
//  JustNotNow
//  Created by Holger Hinzberg on 19.04.25.

import Foundation

struct ToDoItem: Identifiable, Hashable {
    
    let id = UUID()
    var itemDescription: String
    var note: String = ""
    var imageName: String = "star"
    var priority: Int = -1
    var creationDate: Date = Date()
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
    
    static func new() -> ToDoItem {
        ToDoItem(
            itemDescription: "",
            note: "",
            imageName: "star",
            priority: -1,
            creationDate: Date(),
            isCompleted: false
        )
    }
    
    static func sample() -> ToDoItem {
        ToDoItem(
            itemDescription: "Sample Task",
            note: "This is a sample note for the ToDoItem.",
            imageName: "star",
            priority: -1,
            creationDate: Date(),
            reminderDate: Calendar.current.date(byAdding: .day, value: 1, to: Date()),
            isCompleted: false
        )
    }
}

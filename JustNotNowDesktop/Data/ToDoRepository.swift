//  ToDoRepository.swift
//  JustNotNow
//  Created by Holger Hinzberg on 19.04.25.

import Foundation
import Observation
import UserNotifications

@Observable
class ToDoRepository {
    
    //private let badgeManager = ApptBadgeManager()
    private let notificationCenter = UNUserNotificationCenter.current()
    private var toDoItems: [ToDoItem] = []
    
    init() {
        
        toDoItems = [
            ToDoItem(itemDescription: "Buy groceries", imageName: "cart", priority: 1, reminderDate: Date().addingTimeInterval(3600)),
            ToDoItem(itemDescription: "Walk the dog", imageName: "pawprint", priority: 2, reminderDate: nil),
            ToDoItem(itemDescription: "Finish SwiftUI project", imageName: "laptopcomputer", priority: 3, reminderDate: Date().addingTimeInterval(86400)),
            ToDoItem(itemDescription: "Call Mom", imageName: "phone", priority: 4, reminderDate: Date().addingTimeInterval(7200)),
            ToDoItem(itemDescription: "Read a book", imageName: "book", priority: 5, reminderDate: nil),
            ToDoItem(itemDescription: "Go for a walk", imageName: "figure.walk", priority: 6, reminderDate: nil),
        ]
        
        //badgeManager.setBadgeNumber(toDoItems.count)
    }
    
    func addSampleItem() {
        let newItem = ToDoItem(
            itemDescription: "Sample Task",
            imageName: "checkmark.circle",
            priority: Int.random(in: 1...3),  // Random priority between 1 and 3
            reminderDate: Date().addingTimeInterval(3600)  // A reminder set 1 hour from now
        )
        toDoItems.append(newItem)
    }
    
    func sortedByPriority() -> [ToDoItem] {
        return toDoItems.sorted { $0.priority > $1.priority }
    }
    
    func filteredItems(matching filter: String) -> [ToDoItem] {
        guard !filter.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return toDoItems.sorted { $1.priority > $0.priority }
        }
        
        let filtered = toDoItems.filter { $0.matchesFilter(filter) }
        return filtered.sorted { $0.priority > $1.priority }
    }
    
    func add(_ item: ToDoItem) {
        toDoItems.append(item)
        //badgeManager.setBadgeNumber(toDoItems.count)
    }
    
    func clear() {
        toDoItems.removeAll(keepingCapacity: false)
        //badgeManager.setBadgeNumber(toDoItems.count)
    }
    
    func delete(_ item: ToDoItem) {
        toDoItems.removeAll { $0.id == item.id }
        //badgeManager.setBadgeNumber(toDoItems.count)
    }
    
    func toggleCompletion(_ item: ToDoItem) {
        if let index = toDoItems.firstIndex(where: { $0.id == item.id }) {
            toDoItems[index].isCompleted.toggle()
        }
    }
    
    func addOrUpdate(_ item: ToDoItem) {
        if let index = toDoItems.firstIndex(where: { $0.id == item.id }) {
            toDoItems[index] = item
        } else {
            toDoItems.append(item)
        }
    }
}

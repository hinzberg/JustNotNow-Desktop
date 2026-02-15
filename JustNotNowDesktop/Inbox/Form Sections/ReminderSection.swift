//  ReminderSection.swift
//  JustNotNow
//  Created by Holger Hinzberg on 21.04.25.

import SwiftUI

struct ReminderSection: View {
    
    @Binding var item : ToDoItem
    
    var body: some View {
        
        Section(header: Text("Reminder")) {
            Toggle("Set Reminder", isOn: Binding(
                get: { item.reminderDate != nil },
                set: { useReminder in
                    item.reminderDate = useReminder ? Date() : nil
                }
            ))
            
            if item.reminderDate != nil {
                DatePicker("Reminder Date", selection: Binding($item.reminderDate)!, displayedComponents: [.date, .hourAndMinute])
            }
        }
    }
}

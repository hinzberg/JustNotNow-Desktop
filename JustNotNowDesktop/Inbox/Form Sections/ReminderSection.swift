//  ReminderSection.swift
//  JustNotNow
//  Created by Holger Hinzberg on 21.04.25.

import SwiftUI

struct ReminderSection: View {
    
    @Binding var item : ToDoItem
    
    var body: some View {
        
        VStack (alignment: .leading) {
            Toggle("Set Reminder", isOn: Binding(
                get: { item.reminderDate != nil },
                set: { useReminder in
                    item.reminderDate = useReminder ? Date() : nil
                }
            ))
            .font(.title2)
            
            if item.reminderDate != nil {
                DatePicker("", selection: $item.reminderDate ?? Date() , displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.automatic)
                    .font(.title2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Colors.sectionBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

// https://stackoverflow.com/questions/59272801/swiftui-datepicker-binding-optional-date-valid-nil
public func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}

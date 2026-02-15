//  TaskInfoSection.swift
//  JustNotNow
//  Created by Holger Hinzberg on 21.04.25.

import SwiftUI

struct TaskInfoSection: View {
    
   @Binding var item : ToDoItem
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Description")
                .font(.title2)
            TextField("Description", text: $item.itemDescription)
                .font(.title2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 5)
            Text("Note")
                .font(.title2)
            TextField("Note", text: $item.note)
                .font(.title2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Colors.sectionBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}


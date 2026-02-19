//  IconSection.swift
//  JustNotNow
//  Created by Holger Hinzberg on 01.05.25.

import SwiftUI

struct SymbolSection: View {
    
    @Binding var item: ToDoItem
    @State private var showingSymbolPicker = false
    
    var body: some View {
        
        VStack (alignment: .leading)  {
            Text("Symbol")
                .font(.title2)
            HStack {
                Image(systemName: item.imageName )
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .padding(8)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(Colors.primaryAccent, lineWidth: 1)
                    )
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                showingSymbolPicker = true
            }
            // Sheet
            .sheet(isPresented: $showingSymbolPicker) {
                SymbolPickerView(selectedSymbol: Binding(
                    get: { item.imageName },
                    set: { item.imageName = $0 }
                ))
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Colors.sectionBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

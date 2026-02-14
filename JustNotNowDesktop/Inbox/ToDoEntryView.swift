//  ToDoEntryView.swift
//  JustNotNowDesktop

import SwiftUI

struct ToDoEntryView: View {
    @State private var isVisible = false
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
        }
        .opacity(isVisible ? 1 : 0)
        .scaleEffect(isVisible ? 1 : 0.98)
        .onAppear {
            withAnimation(.easeOut(duration: 0.25)) {
                isVisible = true
            }
        }
        .navigationTitle("New To-Do")
    }
}

#Preview {
    NavigationStack {
        ToDoEntryView()
    }
}

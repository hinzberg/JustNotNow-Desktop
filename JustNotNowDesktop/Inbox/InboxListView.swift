//  ToDoListView.swift
//  JustNotNow
//  Created by Holger Hinzberg on 19.04.25.

import SwiftUI

struct InboxListView: View {
    
    @Environment(ToDoRepository.self) private var repository
    @Namespace private var zoomNamespace
    @State private var searchText = ""
    @State private var isNavigatingToAddForm = false
    
    var body: some View {
        
        NavigationStack {
            
            let filteredItems = repository.filteredItems(matching: searchText)
            if filteredItems.isEmpty {
                ContentUnavailableView(
                    searchText.isEmpty ? "No To-Dos" : "No Results",
                    systemImage: searchText.isEmpty ? "checkmark.circle" : "magnifyingglass",
                    description: Text(searchText.isEmpty ? "Tap + to add your first to-do." : "Try a different search term.")
                )
            }
            
            // MARK: List of Items
            List {
                ForEach(filteredItems , id: \.id) { item in
                    NavigationLink {
                        InboxEditView(item: item)
                    } label: {
                        InboxListItemView(item: item)
                    }
                    .listRowSeparator(item == filteredItems.last ? .hidden : .visible)
                    .contextMenu {
                        Button(role: .destructive) {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                repository.delete(item)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(.plain)
            .navigationDestination(isPresented: $isNavigatingToAddForm) {
                InboxEditView(item: ToDoItem.new())
                    .transition(.slide)
            }
            .navigationTitle("Just Not Now")
            
            // MARK: NavigationBar Search
            .searchable(
                text: $searchText,
                placement: .automatic ,
                prompt: "Search ...")
            
            // MARK: NavigationBar Toolbar
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isNavigatingToAddForm = true
                    } label: {
                        Image(systemName: "plus")
                            .matchedTransitionSource(id: "toDoEntry", in: zoomNamespace)
                    }
                }
            }
            Spacer()
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        withAnimation(.easeInOut(duration: 0.25)) {
            for index in offsets {
                let item = repository.filteredItems(matching: searchText)[index]
                repository.delete(item)
            }
        }
    }
}


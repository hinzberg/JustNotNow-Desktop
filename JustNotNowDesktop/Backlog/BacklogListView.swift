//  BacklogListView.swift
//  JustNotNowDesktop
//  Created by Holger Hinzberg on 20.02.26.

import SwiftUI

struct BacklogListView: View {
    
    @Environment(ToDoRepository.self) private var repository
    @Namespace private var zoomNamespace
    @State private var searchText = ""
    
    var body: some View {
        
        NavigationStack {
            
            let filteredItems = repository.filteredBacklogItems(matching: searchText)
            if filteredItems.isEmpty {
                ContentUnavailableView(
                    searchText.isEmpty ? "No Items in Backlog" : "No Results",
                    systemImage: searchText.isEmpty ? "checkmark.circle" : "magnifyingglass",
                    description: Text(searchText.isEmpty ? "" : "Try a different search term.")
                )
            }
            
            // MARK: List of Items
            List {
                ForEach(filteredItems , id: \.id) { item in
                    NavigationLink {
                        BacklogEditView(item: item)
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
                        Button(role: .destructive) {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                repository.moveToUpNext(item)
                            }
                        } label: {
                            Label("Move to Up Next", systemImage: "arrowshape.turn.up.forward")
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(.plain)
            .navigationTitle(AppHelper.getWindowTitleWithVersion())
            
            // MARK: NavigationBar Search
            .searchable(
                text: $searchText,
                placement: .automatic ,
                prompt: "Search ...")

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

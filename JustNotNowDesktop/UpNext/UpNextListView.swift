//  UpNextListView.swift
//  JustNotNowDesktop
//  Created by Holger Hinzberg on 03.03.26.

import SwiftUI

struct UpNextListView: View {
    
    @Environment(ToDoRepository.self) private var repository
    @Namespace private var zoomNamespace
    @State private var searchText = ""
    
    var body: some View {
        
        NavigationStack {
            
            let filteredItems = repository.filteredUpNextItems(matching: searchText)
            if filteredItems.isEmpty {
                ContentUnavailableView(
                    searchText.isEmpty ? "No Items in UpNext" : "No Results",
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
                        UpNextListItemView(item: item)
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
                                repository.moveToBacklog(item)
                            }
                        } label: {
                            Label("Back to Backlog", systemImage: "arrowshape.turn.up.backward")
                        }
                    }
                }
                .onMove(perform: moveUpNextItems)
            }
            .listStyle(.plain)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
            .navigationTitle(AppHelper.getWindowTitleWithVersion())
            
            // MARK: NavigationBar Search
            .searchable(
                text: $searchText,
                placement: .automatic ,
                prompt: "Search ...")
            
            Spacer()
        }
    }
    
    private func moveUpNextItems(from source: IndexSet, to destination: Int) {
        var orderedItems = repository.filteredUpNextItems(matching: searchText)
        orderedItems.move(fromOffsets: source, toOffset: destination)
        repository.updateUpNextPriorities(for: orderedItems)
    }
}

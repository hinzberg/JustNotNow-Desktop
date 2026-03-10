//  BacklogListView.swift
//  JustNotNowDesktop
//  Created by Holger Hinzberg on 20.02.26.

import SwiftUI

struct BacklogListView: View {
    
    @Environment(ToDoRepository.self) private var repository
    @Namespace private var zoomNamespace
    @State private var searchText = ""
    @State private var showUpNextLimitAlert = false
    
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
                                if repository.upNextItemsCount >= AppSettings.shared.MaxItemsUpNext {
                                    showUpNextLimitAlert = true
                                } else {
                                    repository.moveToUpNext(item)
                                }
                            }
                        } label: {
                            Label("Move to Up Next", systemImage: "arrowshape.turn.up.forward")
                        }
                    }
                }
            }
            .listStyle(.plain)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
            .navigationTitle(AppHelper.getWindowTitleWithVersion())
            
            // MARK: NavigationBar Search
            .searchable(
                text: $searchText,
                placement: .automatic ,
                prompt: "Search ...")

            .alert("Too many items in Up Next", isPresented: $showUpNextLimitAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("There are already too many items in Up Next.")
            }

            Spacer()
        }
    }
}

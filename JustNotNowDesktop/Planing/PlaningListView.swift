//  PlaningListView.swift
//  JustNotNowDesktop

import SwiftUI

struct PlaningListView: View {
    
    @Environment(ToDoRepository.self) private var repository
    @State private var searchText = ""
    @State private var showUpNextLimitAlert = false
    
    private enum PlaningSection {
        case inbox, backlog, upNext
    }
    
    var body: some View {
        NavigationStack {
            let inboxItems = repository.filteredInboxItems(matching: searchText)
            let backlogItems = repository.filteredBacklogItems(matching: searchText)
            let upNextItems = repository.filteredUpNextItems(matching: searchText)
            let allEmpty = inboxItems.isEmpty && backlogItems.isEmpty && upNextItems.isEmpty
            
            Group {
                if allEmpty {
                    ContentUnavailableView(
                        searchText.isEmpty ? "No Items" : "No Results",
                        systemImage: searchText.isEmpty ? "checkmark.circle" : "magnifyingglass",
                        description: Text(searchText.isEmpty ? "" : "Try a different search term.")
                    )
                } else {
                    List {
                        Section("Inbox") {
                            ForEach(inboxItems, id: \.id) { item in
                                planingRowInboxOrBacklog(item: item, items: inboxItems, section: .inbox)
                            }
                            sectionDropSpacer(.inbox)
                        }
                        Section("Backlog") {
                            ForEach(backlogItems, id: \.id) { item in
                                planingRowInboxOrBacklog(item: item, items: backlogItems, section: .backlog)
                            }
                            sectionDropSpacer(.backlog)
                        }
                        Section("Up Next") {
                            ForEach(upNextItems, id: \.id) { item in
                                planingRowUpNext(item: item, items: upNextItems)
                            }
                            .onMove(perform: moveUpNextItems)
                            sectionDropSpacer(.upNext)
                        }
                    }
                    .listStyle(.plain)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
                }
            }
            .navigationTitle(AppHelper.getWindowTitleWithVersion())
            .searchable(text: $searchText, placement: .automatic, prompt: "Search ...")
            .alert("Too many items in Up Next", isPresented: $showUpNextLimitAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("There are already too many items in Up Next.")
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func planingRowInboxOrBacklog(item: ToDoItem, items: [ToDoItem], section: PlaningSection) -> some View {
        NavigationLink {
            BacklogEditView(item: item)
        } label: {
            InboxListItemView(item: item)
        }
        .listRowSeparator(item == items.last ? .hidden : .visible)
        .draggable(item.id.uuidString)
        .dropDestination(for: String.self) { strings, _ in
            applySectionDrop(strings, section: section)
        }
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
    
    @ViewBuilder
    private func planingRowUpNext(item: ToDoItem, items: [ToDoItem]) -> some View {
        NavigationLink {
            BacklogEditView(item: item)
        } label: {
            UpNextListItemView(item: item)
        }
        .listRowSeparator(item == items.last ? .hidden : .visible)
        .draggable(item.id.uuidString)
        .dropDestination(for: String.self) { strings, _ in
            applySectionDrop(strings, section: .upNext)
        }
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
                    repository.renumberUpNextItems()
                }
            } label: {
                Label("Back to Backlog", systemImage: "arrowshape.turn.up.backward")
            }
        }
    }
    
    private func sectionDropSpacer(_ section: PlaningSection) -> some View {
        Color.clear
            .frame(minHeight: 24)
            .listRowSeparator(.hidden)
            .contentShape(Rectangle())
            .dropDestination(for: String.self) { strings, _ in
                applySectionDrop(strings, section: section)
            }
    }
    
    private func applySectionDrop(_ strings: [String], section: PlaningSection) -> Bool {
        guard let raw = strings.first, let id = UUID(uuidString: raw) else { return false }
        switch section {
        case .inbox:
            repository.dropOnPlanningInbox(itemId: id)
            return true
        case .backlog:
            repository.dropOnPlanningBacklog(itemId: id)
            return true
        case .upNext:
            if repository.dropOnPlanningUpNext(itemId: id) {
                return true
            }
            showUpNextLimitAlert = true
            return false
        }
    }
    
    private func moveUpNextItems(from source: IndexSet, to destination: Int) {
        var orderedItems = repository.filteredUpNextItems(matching: searchText)
        orderedItems.move(fromOffsets: source, toOffset: destination)
        repository.updateUpNextPriorities(for: orderedItems)
    }
}

#Preview {
    PlaningListView()
}

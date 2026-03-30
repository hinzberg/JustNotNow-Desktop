//  ContentView.swift
//  JustNotNowDesktop
//  Created by Holger Hinzberg on 02.02.26.

import SwiftUI

enum SidebarItem: String, CaseIterable, Identifiable {
    case inbox = "Inbox"
    case backlog = "Backlog"
    case upNext = "Up Next"
    case planing = "Planing"
    var id: Self { self }
}

struct ContentView: View {
    @Environment(ToDoRepository.self) private var repository
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var selection: SidebarItem? = .upNext
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(SidebarItem.allCases, selection: $selection) { item in
                SidebarRowView(
                    text: item.rawValue,
                    systemImage: symbol(for: item),
                    count: count(for: item)
                )
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
        } detail: {
            Group {
                switch selection ?? .inbox {
                case .inbox:
                    InboxView()
                case .backlog:
                    BacklogView()
                case .upNext:
                    UpNextView()
                case .planing:
                    PlaningView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private func count(for item: SidebarItem) -> Int {
        switch item {
        case .inbox:
            return repository.inboxItemsCount
        case .backlog:
            return repository.backlogItemsCount
        case .upNext:
            return repository.upNextItemsCount
        case .planing:
            return repository.inboxItemsCount + repository.backlogItemsCount + repository.upNextItemsCount
        }
    }
    
    private func symbol(for item: SidebarItem) -> String {
        switch item {
        case .inbox:
            return "tray"
        case .backlog:
            return "archivebox"
        case .upNext:
            return "calendar"
        case .planing:
            return "square.grid.2x2"
        }
    }
}

struct SidebarRowView: View {
    let text: String
    let systemImage: String
    let count: Int?
    
    var body: some View {
        Label(text, systemImage: systemImage)
            .font(.title2)
            .badge(
                Text("\(count ?? 0)")
                    .font(.title2)
            )
    }
}

#Preview {
    ContentView()
}

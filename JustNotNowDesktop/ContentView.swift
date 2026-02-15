//
//  ContentView.swift
//  JustNotNowDesktop
//
//  Created by Holger Hinzberg on 02.02.26.
//

import SwiftUI

enum SidebarItem: String, CaseIterable, Identifiable {
    case inbox = "Inbox"
    case backlog = "Backlog"
    case upNext = "Up Next"
    var id: Self { self }
}

struct ContentView: View {
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var selection: SidebarItem? = .inbox

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(SidebarItem.allCases, selection: $selection) { item in
                Label(item.rawValue, systemImage: symbol(for: item))
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
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        }
    }
}

#Preview {
    ContentView()
}

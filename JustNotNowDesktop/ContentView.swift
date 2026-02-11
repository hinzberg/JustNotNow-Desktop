//
//  ContentView.swift
//  JustNotNowDesktop
//
//  Created by Holger Hinzberg on 02.02.26.
//

import SwiftUI

enum SidebarItem: String, CaseIterable, Identifiable {
    case inbox = "Inbox"
    case daily = "Daily"
    case backlog = "Backlog"
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
                case .daily:
                    DailyView()
                case .backlog:
                    BacklogView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            /*
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button {
                        withAnimation {
                            columnVisibility = columnVisibility == .all ? .detailOnly : .all
                        }
                    } label: {
                        Label(
                            columnVisibility == .all ? "Hide Sidebar" : "Show Sidebar",
                            systemImage: columnVisibility == .all ? "sidebar.left" : "sidebar.right"
                        )
                    }
                }
            }
            */
        }
    }

    private func symbol(for item: SidebarItem) -> String {
        switch item {
        case .inbox:
            return "tray"
        case .daily:
            return "calendar"
        case .backlog:
            return "archivebox"
        }
    }
}

#Preview {
    ContentView()
}

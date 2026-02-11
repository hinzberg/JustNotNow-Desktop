//
//  JustNotNowDesktopApp.swift
//  JustNotNowDesktop
//
//  Created by Holger Hinzberg on 02.02.26.
//

import SwiftUI

@main
struct JustNotNowDesktopApp: App {
    
    var repository = ToDoRepository()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(repository)
        }
    }
}

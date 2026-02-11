//
//  InboxView.swift
//  JustNotNowDesktop
//
//  Created by Cursor AI on 02.02.26.
//

import SwiftUI

struct InboxView: View {
    var body: some View {
        ZStack {
            Color.blue.opacity(0.15)
                .ignoresSafeArea()

            Text("Inbox")
                .font(.largeTitle)
                .padding()
        }
    }
}

#Preview {
    InboxView()
}


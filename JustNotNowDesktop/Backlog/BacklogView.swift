//
//  BacklogView.swift
//  JustNotNowDesktop
//
//  Created by Cursor AI on 02.02.26.
//

import SwiftUI

struct BacklogView: View {
    var body: some View {
        ZStack {
            Color.orange.opacity(0.15)
                .ignoresSafeArea()

            Text("Backlog")
                .font(.largeTitle)
                .padding()
        }
    }
}

#Preview {
    BacklogView()
}


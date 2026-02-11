//
//  DailyView.swift
//  JustNotNowDesktop
//
//  Created by Cursor AI on 02.02.26.
//

import SwiftUI

struct DailyView: View {
    var body: some View {
        ZStack {
            Color.green.opacity(0.15)
                .ignoresSafeArea()

            Text("Daily")
                .font(.largeTitle)
                .padding()
        }
    }
}

#Preview {
    DailyView()
}


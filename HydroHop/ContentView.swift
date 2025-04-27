//
//  ContentView.swift
//  HydroHop
//
//  Created by Agam Singh Talwar on 2025-04-22.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedCard: Int? = nil

    var body: some View {
        VStack {
            Spacer()
            CardView(title: "Drink Water", notificationDuration: 45, emoji: "💧", streak: 3)
            Spacer()
            CardView(title: "Stand Up", notificationDuration: 30, emoji: "🚶", streak: 9)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

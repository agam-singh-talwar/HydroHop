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
            CardView(title: "Sip your water", emoji: "💧", time: "25 minutes")
                .frame(height: selectedCard == 0 ? 200 : 100)
                .onTapGesture {
                    withAnimation {
                        selectedCard = (selectedCard == 0) ? nil : 0
                    }
                }

            CardView(title: "Stand up reminder", emoji: "🕺", time: "1 hour")
                .frame(height: selectedCard == 1 ? 200 : 100)
                .onTapGesture {
                    withAnimation {
                        selectedCard = (selectedCard == 1) ? nil : 1
                    }
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

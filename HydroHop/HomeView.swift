//
//  HomeView.swift
//  HydroHop
//
//  Created by Agam Singh Talwar on 2025-04-22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack{
            VStack{
                HeaderView()
                    .zIndex(1)
                Spacer()
                ContentView()
                Spacer()
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}


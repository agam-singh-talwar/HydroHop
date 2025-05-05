//
//  HydroHopApp.swift
//  HydroHop
//
//  Created by Agam Singh Talwar on 2025-04-22.
//

import SwiftUI

@main
struct HydroHopApp: App {
    @AppStorage("hasSeenLanding") private var hasSeenLanding: Bool = false
    var body: some Scene {
        WindowGroup {
            if hasSeenLanding {
                HomeView()
            } else {
                LandingView()
            }
        }
    }
}

//
//  geubchelinApp.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import SwiftUI

@main
struct geubchelinApp: App {
    @AppStorage("showOnboardingView") private var showOnboardingView = true
    @State var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            VStack(spacing: 0) {
                if !networkMonitor.isConnected {
                    NoInternetView()
                }
                
                ContentView()
            }
            .sheet(isPresented: $showOnboardingView) {
                OnboardingView()
                    .interactiveDismissDisabled()
            }
            .animation(.default, value: networkMonitor.isConnected)
        }
    }
}

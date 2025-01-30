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
    @State private var networkMonitor = NetworkMonitor()
    @State private var showOfflineAlert = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .alert("셀룰러 데이터가 꺼져 있음", isPresented: $showOfflineAlert) {
                    Button {
                        print(showOfflineAlert)
                    } label: {
                        Text("설정")
                    }
                    Button {
                        print(showOfflineAlert)
                    } label: {
                        Text("확인")
                    }
                } message: {
                    Text("데이터에 접근하려면, 셀룰러 데이터를 켜거나 Wi-Fi를 사용하십시오.")
                }
                .onAppear {
                    if !showOnboardingView {
                        showOfflineAlert = !networkMonitor.isConnected
                    }
                }
                .onChange(of: networkMonitor.isConnected) { _, newValue in
                    showOfflineAlert = newValue == false
                }
                .sheet(isPresented: $showOnboardingView) {
                    OnboardingView()
                        .interactiveDismissDisabled()
                }
        }
    }
}

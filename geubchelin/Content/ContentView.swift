//
//  ContentView.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import SwiftUI

enum AppTab: String, CaseIterable {
    case home = "홈"
    case mealPlan = "식단"
//    case timetable = "시간표"
    case more = "더보기"
    
    var systemImage: String {
        switch self {
        case .home: return "house"
        case .mealPlan: return "calendar"
//        case .timetable: return "clock"
        case .more: return "ellipsis"
        }
    }
    
    @ViewBuilder var view: some View {
        switch self {
        case .home: HomeView()
        case .mealPlan: CalendarView()
//        case .timetable: EmptyView()
        case .more: MoreView()
        }
    }
}

struct ContentView: View {
    @State private var selection: AppTab? = .home
    
    var body: some View {
        if #available(iOS 18, *) {
            TabView(selection: $selection) {
                ForEach(AppTab.allCases, id: \.self) { tab in
                    Tab(tab.rawValue, systemImage: tab.systemImage, value: tab) {
                        tab.view
                    }
                }
            }
            .tabViewStyle(.sidebarAdaptable)
        } else {
            TabView(selection: $selection) {
                ForEach(AppTab.allCases, id: \.self) { tab in
                    tab.view
                        .tabItem {
                            Image(systemName: tab.systemImage)
                            Text(tab.rawValue)
                        }
                        .tag(tab)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

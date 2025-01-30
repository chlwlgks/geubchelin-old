//
//  ContentView.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
#if os(iOS)
        if #available(iOS 18, *) {
            TabView {
                Tab("홈", systemImage: "house") {
                    HomeView()
                }
                Tab("식단", systemImage: "calendar") {
                    MealPlanView()
                }
                Tab("더보기", systemImage: "ellipsis") {
                    MoreView()
                }
            }
        } else {
            TabView() {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("홈")
                    }
                MealPlanView()
                    .tabItem {
                        Image("calendar")
                        Text("식단")
                    }
                MoreView()
                    .tabItem {
                        Image("ellipsis")
                        Text("더보기")
                    }
            }
        }
#else
#endif
    }
}

#Preview {
    ContentView()
}

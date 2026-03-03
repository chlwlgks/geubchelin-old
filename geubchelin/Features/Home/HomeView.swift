//
//  HomeView.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import SwiftUI
//import GoogleMobileAds

struct HomeView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.scenePhase) private var scenePhase
    
    @AppStorage("schoolName") private var schoolName: String?
    
    @State private var viewModel = HomeViewModel()
    @State private var allergyViewModel = AllergySelectionViewModel()
    
    var body: some View {
        if let schoolName {
            NavigationStack {
                Group {
                    if horizontalSizeClass == .regular {
                        RegularHomeView()
                        Spacer()
                    } else {
                        CompactHomeView()
                    }
                }
                .environment(viewModel)
                .task(id: scenePhase) {
                    guard scenePhase == .active else { return }
                    await viewModel.fetchScheduleAndMeals()
                }
                .navigationTitle(schoolName)
                .applyNavigationSubtitleIfAvailable(viewModel.currentDateAsString())
            }
        }
    }
    
    private struct CompactHomeView: View {
        @Environment(HomeViewModel.self) private var viewModel
        
        private let selectedAllergies: Set<String> = {
            let ids = UserDefaults.standard.array(forKey: "SelectedAllergies") as? [String] ?? []
            return Set(ids)
        }()
        
        var body: some View {
            List {
                if #unavailable(iOS 26.0) {
                    Section {
                        Text(viewModel.currentDateAsString())
                            .foregroundStyle(.secondary)
                            .listSectionSeparator(.hidden)
                    }
                }
                
                if let schedule = viewModel.schedule {
                    Section("학사 일정") {
                        Text(schedule)
                            .contextMenu {
                                Button {
                                    UIPasteboard.general.string = schedule
                                } label: {
                                    Label("복사", systemImage: "document.on.document")
                                }
                                ShareLink(item: schedule)
                            }
                    }
                }
                ForEach(viewModel.meals, id: \.mealKind.rawValue) { meal in
                    Section {
                        if let menus = meal.menus, !menus.isEmpty {
                            VStack(alignment: .leading) {
                                ForEach(menus, id: \.self) { menu in
                                    if let list = menu.allergies, !list.isDisjoint(with: selectedAllergies) {
                                        Text(menu.name)
                                            .foregroundStyle(.red)
                                    } else {
                                        Text(menu.name)
                                    }
                                }
                            }
                            .contextMenu {
                                let menuNames = menus.compactMap({ $0.name })
                                
                                Button {
                                    UIPasteboard.general.strings = menuNames
                                } label: {
                                    Label("복사", systemImage: "document.on.document")
                                }
                                ShareLink(item: menuNames.joined(separator: "\n"))
                            }
                        } else {
                            Text("급식 정보가 없습니다.")
                        }
                    } header: {
                        HStack {
                            Text(meal.mealKind.displayName)
                            if let calorie = meal.calorieInfo {
                                Spacer()
                                Text(calorie)
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)        }
    }
    
    private struct RegularHomeView: View {
        @Environment(HomeViewModel.self) private var viewModel
        
        private let selectedAllergies: Set<String> = {
            let ids = UserDefaults.standard.array(forKey: "SelectedAllergies") as? [String] ?? []
            return Set(ids)
        }()
        
        var body: some View {
            VStack(alignment: .leading) {
                if #unavailable(iOS 26.0) {
                    Text(viewModel.currentDateAsString())
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                }
                
                HStack {
                    if let schedule = viewModel.schedule {
                        List {
                            Section("학사 일정") {
                                Text(schedule)
                                    .listSectionSeparator(.hidden)
                                    .contextMenu {
                                        Button {
                                            UIPasteboard.general.string = schedule
                                        } label: {
                                            Label("복사", systemImage: "document.on.document")
                                        }
                                        ShareLink(item: schedule)
                                    }
                            }
                        }
                        .scrollDisabled(true)
                        .listStyle(.plain)
                        .contentMargins(0)
                        
                        Divider()
                    }
                    ForEach(viewModel.meals, id: \.mealKind.rawValue) { meal in
                        List {
                            Section {
                                if let menus = meal.menus, !menus.isEmpty {
                                    VStack(alignment: .leading) {
                                        ForEach(menus, id: \.self) { menu in
                                            if let list = menu.allergies, !list.isDisjoint(with: selectedAllergies) {
                                                Text(menu.name)
                                                    .foregroundStyle(.red)
                                            } else {
                                                Text(menu.name)
                                            }
                                        }
                                    }
                                    .contextMenu {
                                        let menuNames = menus.compactMap({ $0.name })
                                        
                                        Button {
                                            UIPasteboard.general.strings = menuNames
                                        } label: {
                                            Label("복사", systemImage: "document.on.document")
                                        }
                                        ShareLink(item: menuNames.joined(separator: "\n"))
                                    }
                                } else {
                                    Text("급식 정보가 없습니다.")
                                }
                            } header: {
                                HStack {
                                    Text(meal.mealKind.displayName)
                                    if let calorie = meal.calorieInfo {
                                        Spacer()
                                        Text(calorie)
                                    }
                                }
                            }
                            .listSectionSeparator(.hidden)
                        }
                        .scrollDisabled(true)
                        .listStyle(.plain)
                        .contentMargins(0)
                        
                        if meal.mealKind.rawValue != "3" {
                            Divider()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

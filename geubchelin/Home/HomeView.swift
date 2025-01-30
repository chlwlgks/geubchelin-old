//
//  HomeView.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import SwiftUI
import GoogleMobileAds

struct HomeView: View {
    @AppStorage("schoolName") private var schoolName: String?
    
    @State private var viewModel = HomeViewModel()
    @State private var allergyViewModel = AllergySelectionViewModel()
    
    var body: some View {
        if let schoolName {
            NavigationStack {
                VStack {
                    Text(viewModel.currentDateAsString())
                        .font(.system(.title3, weight: .semibold))
                    if false {
//                    if viewModel.meals.allSatisfy({ $0.menu == nil }) {
                        Spacer()
                        Text("급식 정보가 없습니다.")
                            .font(.title3)
                        Spacer()
                    } else {
                        ScrollView {
//                            MealListView(meals: viewModel.meals) { dishes in
                            MealListView(meals: Meal.sampleMeals) { dishes in
                                let dishTexts = dishes.enumerated().compactMap { (index, dish) -> Text in
                                    let hasAllergy = dish.allergies.contains(where: { allergyViewModel.selectedAllergies.contains($0) })
                                    let baseText = Text(dish.name)
                                        .foregroundStyle(hasAllergy ? .red : .primary)
                                    return index < dishes.count - 1 ? baseText + Text(", ") : baseText
                                }
                                dishTexts.reduce(Text(""), +)
//                                    .background(Color.yellow.opacity(0.5))
                            }
                        }
                        .padding(.horizontal)
                    }
                    
//                    BannerView()
//                        .frame(width: UIScreen.main.bounds.width, height: GADLandscapeAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width).size.height)
                }
                .navigationTitle(schoolName)
                .onAppear {
                    Task {
                        await viewModel.fetchMeals()
                    }
                    allergyViewModel = AllergySelectionViewModel()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

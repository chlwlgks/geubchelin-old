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
        VStack {
            if let schoolName {
                VStack(alignment: .leading) {
                    Text(viewModel.currentDateAsString())
                        .font(.system(.subheadline, weight: .semibold))
                        .foregroundStyle(.gray)
                    Text(schoolName)
                        .font(.system(.largeTitle, weight: .bold))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                .padding(.top)
                
                if false {
                    //                    if viewModel.meals.allSatisfy({ $0.menu == nil }) {
                    Spacer()
                    Text("급식 정보가 없습니다.")
                        .font(.title3)
                    Spacer()
                } else {
                    List(Meal.sampleMeals, id: \.mealCode) { meal in
                        if let menus = meal.menus {
                            VStack(alignment: .leading) {
                                HStack(alignment:.center) {
                                    Text(meal.mealType)
                                        .font(.system(.title3, weight: .semibold))
                                    Spacer()
                                    Text(meal.calorieInfo ?? "")
                                        .font(.system(.callout, weight: .semibold))
                                        .foregroundStyle(.gray)
                                }
                                ForEach(menus, id: \.self) { menu in
                                    Text(viewModel.createMenuWithAllergies(menu: menu, selectedAllergies: allergyViewModel.selectedAllergies, isHighlighted: menu == viewModel.highlightedMenu))
//                                        .onTapGesture {
//                                            if viewModel.highlightedMenu == menu {
//                                                viewModel.highlightedMenu = nil
//                                            } else {
//                                                viewModel.highlightedMenu = menu
//                                            }
//                                        }
                                }
                            }
                            .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            
//            BannerView()
//                .frame(width: UIScreen.main.bounds.width, height: GADLandscapeAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width).size.height)
        }
        .padding(.horizontal)
        .onAppear {
            Task {
                await viewModel.fetchMeals()
            }
            allergyViewModel = AllergySelectionViewModel()
        }
    }
}

#Preview {
    HomeView()
}

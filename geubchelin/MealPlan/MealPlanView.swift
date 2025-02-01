//
//  MealPlanView.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import SwiftUI

struct MealPlanView: View {
    @State private var viewModel = MealPlanViewModel()
    @State private var allergyViewModel = AllergySelectionViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker("날짜", selection: $viewModel.selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding(.horizontal)
                if false {
//                if viewModel.meals.allSatisfy({ $0.menu == nil }) {
                    Spacer()
                    Text("급식 정보가 없습니다.")
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        Button {
                            print("Good")
                        } label: {
//                            MealListView(meals: viewModel.meals) { dishes in
                            MealListView(meals: Meal.sampleMeals) { dishes in
                                let dishTexts = dishes.enumerated().compactMap { (index, dish) -> Text in
                                    let hasAllergy = dish.allergies?.contains(where: { allergyViewModel.selectedAllergies.contains($0) }) ?? false
                                    let baseText = Text(dish.name)
                                        .foregroundStyle(hasAllergy ? .red : .primary)
                                    return index < dishes.count - 1 ? baseText + Text(", ") : baseText
                                }
                                dishTexts.reduce(Text(""), +)
//                                    .background(Color.yellow.opacity(0.5))
                            }
                        }
                        .buttonStyle(.plain)
                        Button {
                            print("dd")
                        } label: {
                            Text("자세히 보기")
                                .padding(.horizontal)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.bottom)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("식단")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                Task {
                    await viewModel.fetchMeals()
                }
                allergyViewModel = AllergySelectionViewModel()
            }
            .onChange(of: viewModel.selectedDate) {
                Task {
                    await viewModel.fetchMeals()
                }
            }
        }
    }
}

#Preview {
    MealPlanView()
}

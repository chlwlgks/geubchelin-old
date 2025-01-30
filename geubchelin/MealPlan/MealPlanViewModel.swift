//
//  MealPlanViewModel.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import Foundation

@Observable
class MealPlanViewModel {
    var selectedDate = Date()
    
    var meals: [Meal] = []
    
    init() {
        Task {
            meals = await FetchMeals().fetchMeals(date: selectedDate)
        }
    }
    
    func fetchMeals() async {
        meals = await FetchMeals().fetchMeals(date: selectedDate)
    }
}

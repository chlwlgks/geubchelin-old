//
//  HomeViewModel.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import Foundation

@Observable
class HomeViewModel {
    var meals: [Meal] = []
    
    init() {
        Task {
            meals = await FetchMeals().fetchMeals(date: Date())
        }
    }
    
    func currentDateAsString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 d일"
        return dateFormatter.string(from: Date())
    }
    
    func fetchMeals() async {
        meals = await FetchMeals().fetchMeals(date: Date())
    }
}

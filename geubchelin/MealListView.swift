//
//  MealListView.swift
//  geubchelin
//
//  Created by 최지한 on 1/27/25.
//

import SwiftUI

struct MealListView<Content: View>: View {
    let meals: [Meal]
    let content : ([Menu]) -> Content
    
    init(meals: [Meal], @ViewBuilder content: @escaping ([Menu]) -> Content) {
        self.meals = meals
        self.content = content
    }
    
    var body: some View {
        VStack {
            ForEach(meals, id: \.mealCode) { meal in
                if let dishes = meal.menus {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(meal.mealType)
                            Spacer()
                            Text(meal.calorieInfo ?? "")
                        }
                        .font(.system(.subheadline, weight: .semibold))
                        .foregroundStyle(.secondary)
                        
                        content(dishes)
                    }
                    .padding()
                }
            }
        }
    }
}

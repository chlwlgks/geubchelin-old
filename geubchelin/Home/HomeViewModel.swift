//
//  HomeViewModel.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import Foundation
import SwiftUI

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
        dateFormatter.dateFormat = "M월 d일 EEEE"
        return dateFormatter.string(from: Date())
    }
    
    func fetchMeals() async {
        meals = await FetchMeals().fetchMeals(date: Date())
    }
    
    var highlightedMenu: Menu?
    
    func createMenuWithAllergies(menu: Menu, selectedAllergies: Set<String>, isHighlighted: Bool) -> AttributedString {
        var result = AttributedString(menu.name)
        
        if menu.allergies?.contains(where: { selectedAllergies.contains($0) }) ?? false {
            result.foregroundColor = .red
        }
        if isHighlighted {
            result.backgroundColor = .yellow.opacity(0.5)
        }
        
        if let allergies = menu.allergies {
            result.append(AttributedString(" ("))
            
            for (index, allergy) in allergies.enumerated() {
                if index > 0 {
                    result.append(AttributedString(", "))
                }
                
                var allergyText = AttributedString(allergy)
                if selectedAllergies.contains(allergy) {
                    allergyText.foregroundColor = .red
                }
                
                result.append(allergyText)
            }
            
            result.append(AttributedString(")"))
        }
        
        return result
        
        
        
        
        
        
        
        
        
        
        
//        if let allergies = menu.allergies {
//            var menuText: Text
//            if selectedAllergies.isDisjoint(with: allergies) {
//                menuText = Text(menu.name)
//            } else {
//                menuText = Text(menu.name).foregroundStyle(.red)
//            }
//            
//            let allergyText = selectedAllergies.reduce(Text("(")) { partialResult, allergy in
//                let allergyComponet: Text
//                if selectedAllergies.contains(allergy) {
//                    allergyComponet = Text(allergy).foregroundStyle(.red)
//                } else {
//                    allergyComponet = Text(allergy)
//                }
//                return partialResult + allergyComponet + Text(", ")
//            }
//            
//            let finalAllergyText = allergyText + Text(")")
//            
//            return menuText + Text(" ") + finalAllergyText
//        } else {
//            return Text(menu.name)
//        }
        
        
        
        
        
        
        
//        if let allergies = menu.allergies {
//            let formattedAllergyText = allergies.compactMap { allergy in
//                if selectedAllergies.contains(allergy) {
//                    Text(allergy).foregroundStyle(.red)
//                } else {
//                    Text(allergy)
//                }
//            }
//            
//            let menuText: Text
//            if selectedAllergies.isDisjoint(with: allergies) {
//                menuText = Text(menu.name)
//            } else {
//                menuText = Text(menu.name).foregroundStyle(.red)
//            }
//            
//            return HStack {
//                menuText
//                Text("(")
//                ForEach(0..<formattedAllergyText.count) { index in
//                    formattedAllergyText[index]
//                    if index < formattedAllergyText.count - 1 {
//                        Text(", ")
//                    }
//                }
//                Text(")")
//            }
//        } else {
//            return Text(menu.name)
//        }
    }
}

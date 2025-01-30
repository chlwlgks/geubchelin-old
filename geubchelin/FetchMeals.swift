//
//  FetchMeals.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import Foundation
import SwiftUI

class FetchMeals {
    private let apiKey: String = Bundle.main.infoDictionary!["API Key"] as! String
    
    @AppStorage("schoolOfficeCode") private var schoolOfficeCode: String?
    @AppStorage("schoolCode") private var schoolCode: String?
    
    func fetchMeals(date: Date) async -> [Meal] {
        var meals: [Meal] = [
            Meal(id: "1", mealType: "조식"),
            Meal(id: "2", mealType: "중식"),
            Meal(id: "3", mealType: "석식")
        ]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yMMdd"
        let formattedDate = dateFormatter.string(from: date)
        
        let url = URL(string: "https://open.neis.go.kr/hub/mealServiceDietInfo?KEY=\(apiKey)&Type=json&ATPT_OFCDC_SC_CODE=\(schoolOfficeCode ?? "")&SD_SCHUL_CODE=\(schoolCode ?? "")&MLSV_YMD=\(formattedDate)")!
        
//        let url = URL(string: "https://open.neis.go.kr/hub/mealServiceDietInfo?KEY=\(apiKey)&Type=json&ATPT_OFCDC_SC_CODE=\(schoolOfficeCode ?? "")&SD_SCHUL_CODE=\(schoolCode ?? "")&MLSV_YMD=20241108")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoer = JSONDecoder()
            let response = try decoer.decode(Mealresponse.self, from: data)
            
            let rows = response.mealServiceDietInfo[1].row!
            for row in rows {
                if let index = meals.firstIndex(where: { $0.id == row.MMEAL_SC_CODE }) {
                    meals[index].menu = parseMeals(meal: row.DDISH_NM)
                    meals[index].calorieInfo = row.CAL_INFO
                }
            }
            
            return meals
        } catch {
            print("Failed to load meals: \(error.localizedDescription)")
            return meals
        }
    }
    
    func parseMeals(meal: String) -> [Menu] {
        var parsedMenus: [Menu] = []
        
        let lines = meal.split(separator: "<br/>").compactMap { line in
            String(line).trimmingCharacters(in: .whitespaces)
        }
        for line in lines {
            var name = line
            var allergies: [String] = []
            
            if let openParenIndex = line.lastIndex(of: "("), let closeParenIndex = line.lastIndex(of: ")") {
                let insideParen = String(line[line.index(after: openParenIndex)...line.index(before: closeParenIndex)])
                if isAllergyString(insideParen) {
                    allergies = insideParen.components(separatedBy: ".")
                    name = String(line[...line.index(before: openParenIndex)]).trimmingCharacters(in: .whitespaces)
                }
            }
            
            parsedMenus.append(Menu(name: name, allergies: allergies))
        }
        
        return parsedMenus
    }
    
    private func isAllergyString(_ string: String) -> Bool {
        for char in string {
            if !(char.isNumber || char == ".") {
                return false
            }
        }
        return true
    }
}


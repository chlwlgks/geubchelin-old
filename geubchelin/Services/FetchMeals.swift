//
//  FetchMeals.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import SwiftUI

struct MealResponse: Codable {
    let mealServiceDietInfo: [MealServiceDietInfo]
}

struct MealServiceDietInfo: Codable {
    let row: [MealRow]?
}

struct MealRow: Codable {
    let MMEAL_SC_CODE: String // 식사코드
    let MMEAL_SC_NM: String // 식사명
    let DDISH_NM: String // 요리명
    let CAL_INFO: String // 칼로리정보
}

class FetchMeals {
    private let apiKey: String = Bundle.main.infoDictionary!["API Key"] as! String
    
    @AppStorage("schoolOfficeCode") private var schoolOfficeCode: String?
    @AppStorage("schoolCode") private var schoolCode: String?
    
    func fetchMeals(for date: Date) async -> [Meal] {
//        let date = Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 15))!
        
        var meals: [Meal] = [
            Meal(mealKind: .breakfast),
            Meal(mealKind: .lunch),
            Meal(mealKind: .dinner)
        ]
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyyMMdd"
        let formattedDate = dateformatter.string(from: date)
        
        let url = URL(string: "https://open.neis.go.kr/hub/mealServiceDietInfo?KEY=\(apiKey)&Type=json&ATPT_OFCDC_SC_CODE=\(schoolOfficeCode ?? "")&SD_SCHUL_CODE=\(schoolCode ?? "")&MLSV_YMD=\(formattedDate)")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            let response = try decoder.decode(MealResponse.self, from: data)
            
            if let rows = response.mealServiceDietInfo[1].row {
                if let row = rows.first(where: { $0.MMEAL_SC_CODE == "2" }) {
                    let menus = parseMeals(from: row.DDISH_NM)
                    
                    if let idx = meals.firstIndex(where: { $0.mealKind.rawValue == "2" }) {
                        meals[idx].menus = menus
                        meals[idx].calorieInfo = row.CAL_INFO
                    }
                }
            }
        } catch {
            print("중식 로드 오류: \(error.localizedDescription)")
        }
        
        return meals
    }
    
    private func parseMeals(from meal: String) -> [Menu] {
        var parsedMenus: [Menu] = []
        
        let lines = meal.split(separator: "<br/>").compactMap { line in
            String(line).trimmingCharacters(in: .whitespaces)
        }
        for line in lines {
            var name = line
            var allergies: Set<String>?
            
            if let closeParenIndex = line.lastIndex(of: ")") {
                var balance = 0
                var matchingopenParenIndex: String.Index? = nil
                
                for i in line.indices[..<closeParenIndex].reversed() {
                    if line[i] == ")" {
                        balance += 1
                    } else if line[i] == "(" {
                        if balance == 0 {
                            matchingopenParenIndex = i
                            break
                        } else {
                            balance -= 1
                        }
                    }
                }
                
                if let openParenIndex = matchingopenParenIndex {
                    let inside = String(line[line.index(after: openParenIndex)...line.index(before: closeParenIndex)])
                    if isAllergyString(in: inside) {
                        let codes = inside
                            .components(separatedBy: CharacterSet(charactersIn: ".*"))
                            .compactMap { part in
                                return part
                                    .replacingOccurrences(of: "(", with: "")
                                    .replacingOccurrences(of: ")", with: "")
                            }
                        allergies = Set(codes)
                        name = String(line[...line.index(before: openParenIndex)]).trimmingCharacters(in: .whitespaces)
                    }
                }
            }
            
            parsedMenus.append(Menu(name: name, allergies: allergies))
        }
        
        return parsedMenus
    }
    
    private func isAllergyString(in string: String) -> Bool {
        for char in string {
            if !(char.isNumber || char == "." || char == "(" || char == ")" || char == "*") {
                return false
            }
        }
        return true
    }
}


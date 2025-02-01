//
//  Meal.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import Foundation

struct Meal: Hashable {
    let mealCode: String
    let mealType: String
    var menus: [Menu]?
    var calorieInfo: String?
}

struct Menu: Hashable {
    let name: String
    let allergies: [String]?
}

extension Meal {
    static let sampleMeals: [Meal] = [
        Meal(
            mealCode: "1",
            mealType: "조식",
            menus: [
                Menu(name: "크랜베리베이글*크림치즈", allergies: ["2", "6"]),
                Menu(name: "셀프간장계란밥", allergies: ["1", "2", "5", "6"]),
                Menu(name: "테이터잼케이준샐러드", allergies: ["1", "5", "6"]),
                Menu(name: "올리브파래자반", allergies: ["5"]),
                Menu(name: "볶음김치", allergies: ["5", "6", "9"]),
                Menu(name: "감귤주스", allergies: nil),
                Menu(name: "오곡코코볼*우유", allergies: ["2", "5", "6"]),
            ]
        ),
        Meal(
            mealCode: "2",
            mealType: "중식",
            menus: [
                Menu(name: "추가밥", allergies: nil),
                Menu(name: "얼음동동김치말이국수(왕대접)", allergies: ["1", "5", "6", "9", "13", "16"]),
                Menu(name: "케이크", allergies: ["1", "2", "5", "6"]),
                Menu(name: "무피클(수제)", allergies: ["13"]),
                Menu(name: "반마리옛날통닭", allergies: ["1", "5", "6", "15", "16"]),
                Menu(name: "소다", allergies: ["2"])
            ],
            calorieInfo: "1034.7 Kcal"
        ),
        Meal(
            mealCode: "3",
            mealType: "석식",
            menus: [
                Menu(name: "해물짬뽕", allergies: ["5", "6", "9", "17", "18"]),
                Menu(name: "굴소스야채볶음밥", allergies: ["5", "6", "13", "18"]),
                Menu(name: "꿔바로우탕수육", allergies: ["5", "6", "10", "12", "16"]),
                Menu(name: "오복지무침", allergies: ["5", "6"]),
                Menu(name: "깍두기", allergies: ["9"]),
                Menu(name: "아이스망고", allergies: nil)
            ]
        )
    ]
}

struct Mealresponse: Codable {
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

struct Allergy: Identifiable {
    let id: String
    let name: String
}

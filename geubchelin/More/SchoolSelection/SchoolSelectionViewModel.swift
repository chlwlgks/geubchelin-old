//
//  SchoolSelectionViewModel.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import Foundation

@Observable
class SchoolSelectionViewModel {
    private let apiKey: String = Bundle.main.infoDictionary!["API Key"] as! String
    
    var schools: [School]?
    
    var searchText = ""
    var selectedRegion = ""
    
    let regions = [
        ("모든 지역", ""),
        ("서울", "서울특별시"),
        ("부산", "부산광역시"),
        ("대구", "대구광역시"),
        ("인천", "인천광역시"),
        ("광주", "광주광역시"),
        ("대전", "대전광역시"),
        ("울산", "울산광역시"),
        ("세종", "세종특별자치시"),
        ("경기", "경기도"),
        ("강원", "강원특별자치도"),
        ("충북", "충청북도"),
        ("충남", "충청남도"),
        ("전북", "전북특별자치도"),
        ("전남", "전라남도"),
        ("경북", "경상북도"),
        ("경남", "경상남도"),
        ("제주", "제주특별자치도")
    ]
    
    init() {
        Task {
            await loadSchools()
        }
    }
    
    func loadSchools() async {
        let url = URL(string: "https://open.neis.go.kr/hub/schoolInfo?KEY=\(apiKey)&Type=json&SCHUL_NM=\(searchText)&LCTN_SC_NM=\(selectedRegion)")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoer = JSONDecoder()
            let response = try decoer.decode(SchoolResponse.self, from: data)
            
            let rows = response.schoolInfo[1].row!
            
            let newSchools = rows.compactMap { row in
                School(officeCode: row.ATPT_OFCDC_SC_CODE, code: row.SD_SCHUL_CODE, name: row.SCHUL_NM, address: row.ORG_RDNMA)
            }
            schools = newSchools
        } catch {
            schools = nil
            print("Failed to load schools: \(error.localizedDescription)")
        }
    }
}

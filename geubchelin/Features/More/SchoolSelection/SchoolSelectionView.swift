//
//  SchoolSelectionView.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import SwiftUI

struct SchoolSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("schoolOfficeCode") private var schoolOfficeCode: String?
    @AppStorage("schoolCode") private var schoolCode: String?
    @AppStorage("schoolName") private var schoolName: String?
    
    @State private var viewModel = SchoolSelectionViewModel()
    
    var body: some View {
        List(viewModel.schools, id: \.code) { school in
            Button {
                selectSchool(school: school)
                dismiss()
                HapticManager.instance.notification(notificationType: .success)
            } label: {
                VStack(alignment: .leading) {
                    Text(school.name)
                    Text(school.address)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .searchable(text: $viewModel.searchText)
        .overlay {
            if viewModel.schools.isEmpty {
                ContentUnavailableView("결과 없음", systemImage: "magnifyingglass", description: Text("새로운 검색을 시도하십시오."))
            }
        }
        //        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        .scrollDismissesKeyboard(.immediately)
        .listStyle(.plain)
        .navigationTitle("학교 선택")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Picker("지역 선택", selection: $viewModel.selectedRegion) {
                ForEach(viewModel.regions, id: \.0) { region in
                    Text(region.0).tag(region.1)
                }
            }
        }
        .onChange(of: [viewModel.searchText, viewModel.selectedRegion]) {
            Task {
                await viewModel.loadSchools()
            }
        }
    }
    
    private func selectSchool(school: School) {
        schoolOfficeCode = school.officeCode
        schoolCode = school.code
        schoolName = school.name
    }
}

#Preview {
    SchoolSelectionView()
}

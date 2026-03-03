//
//  UserInfoInputView.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import SwiftUI

struct UserInfoInputView: View {
    @AppStorage("showOnboardingView") private var showOnboardingView = true
    @AppStorage("schoolName") private var schoolName: String?
    
    @State private var allergySelectionViewModel = AllergySelectionViewModel()
    
    var body: some View {
        VStack {
            List {
                Section {
                    NavigationLink {
                        SchoolSelectionView()
                    } label: {
                        LabeledContent("학교 선택") {
                            if let schoolName {
                                Text(schoolName)
                            }
                        }
                    }
                }
                
                Section {
                    NavigationLink {
                        AllergySelectionView()
                            .environment(allergySelectionViewModel)
                    } label: {
                        LabeledContent("알레르기 유발 식품 선택") {
                            if !allergySelectionViewModel.selectedAllergies.isEmpty {
                                Text("\(allergySelectionViewModel.selectedAllergies.count)개")
                            }
                        }
                    }
                }
            }
            .adaptiveSafeAreaBottom {
                Button {
                    showOnboardingView = false
                } label: {
                    Text("완료")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, maxHeight: 35)
                }
                .adaptiveProminentButtonStyle()
                .disabled(schoolName == nil)
                .padding(.horizontal)
                .padding(.horizontal)
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .navigationTitle("프로필 설정")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    UserInfoInputView()
}

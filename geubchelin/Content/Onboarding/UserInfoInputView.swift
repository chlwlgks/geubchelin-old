//
//  UserInfoInputView.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import SwiftUI

struct UserInfoInputView: View {
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("showOnboardingView") private var showOnboardingView = true
    @AppStorage("schoolName") private var schoolName: String?
    
    var body: some View {
        VStack {
            List {
                Section {
                    NavigationLink {
                        SchoolSelectionView()
                    } label: {
                        HStack {
                            Text("학교 선택")
                            if let schoolName {
                                Spacer()
                                Text(schoolName)
                                    .foregroundStyle(.gray)
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                    }
                }
                Section {
                    NavigationLink {
                        AllergySelectionView()
                    } label: {
                        Text("알레르기 유발 식품 선택")
                    }
                }
            }
            .scrollDisabled(true)
            
            Button {
                showOnboardingView = false
            } label: {
                Text("완료")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, maxHeight: 35)
            }
            .disabled(schoolName == nil)
            .buttonStyle(.borderedProminent)
            .sensoryFeedback(.success, trigger: showOnboardingView)
            .padding()
        }
        .navigationTitle("프로필 설정")
    }
}

#Preview {
    UserInfoInputView()
}

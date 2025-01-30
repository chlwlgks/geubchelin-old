//
//  MoreView.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import SwiftUI

struct MoreView: View {
    @AppStorage("schoolName") private var schoolName: String?
    @AppStorage("showOnboardingView") private var showOnboardingView = true
    
    @State private var isShowingPrivacyPolicyView: Bool = false
    
    var body: some View {
        NavigationStack {
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
                Section {
                    Button {
                        UIApplication.shared.open(URL(string: "https://www.instagram.com/j1hxna/")!)
                    } label: {
                        Text("개발자에게 문의하기")
                    }
                    
                    Button {
                        isShowingPrivacyPolicyView = true
                    } label: {
                        Text("개인정보 처리방침")
                    }
                    
                    NavigationLink {
                        AppInfoView()
                    } label: {
                        Text("앱 정보")
                    }
                }
            }
            .scrollDisabled(true)
            .navigationTitle("더보기")
            .sheet(isPresented: $isShowingPrivacyPolicyView) {
                PrivacyPolicyView()
            }
        }
    }
}

#Preview {
    MoreView()
}

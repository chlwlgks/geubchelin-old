//
//  OnboardingView.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import SwiftUI

private struct Feature: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let description: String
}

private struct FeatureRow: View {
    let feature: Feature
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: feature.image)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.accent)
                .frame(width: 35, height: 35)
                .padding(.trailing)
            
            VStack(alignment: .leading) {
                Text(feature.title)
                    .font(.callout.weight(.semibold))
                Text(feature.description)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.bottom)
    }
}

struct OnboardingView: View {
    private let features: [Feature] = [
        Feature(image: "fork.knife", title: "급식", description: "홈 화면에서 급식과 학사일정을 빠르게 확인하세요. 칼로리 정보도 표시됩니다."),
        Feature(image: "calendar", title: "캘린더로 보기", description: "캘린더를 통해 원하는 날짜의 급식과 학사일정을 확인하세요."),
        Feature(image: "clock.fill", title: "시간표", description: "주간 시간표를 한눈에 확인하세요."),
        Feature(image: "bell.badge.fill", title: "급식 알림", description: "원하는 시각에 조식, 중식, 석식 알림을 설정할 수 있습니다."),
        Feature(image: "allergens.fill", title: "알레르기 유발 식품 경고", description: "알레르기 유발 식품을 설정하면 해당 음식이 빨간색으로 표시됩니다.")
    ]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("급슐랭 시작하기")
                    .font(.title2.weight(.bold))
                    .padding(.vertical)
                    .padding(.top)
                    .padding(.top)
                    .padding(.top)
                    .padding(.top)
                
                VStack(alignment: .leading) {
                    ForEach(features) { feature in
                        FeatureRow(feature: feature)
                    }
                }
                
                Spacer()
            }
            .adaptiveSafeAreaBottom {
                NavigationLink {
                    UserInfoInputView()
                } label: {
                    Text("계속")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, maxHeight: 40)
                }
                .adaptiveProminentButtonStyle()
                .padding(.bottom)
            }
            .padding(.horizontal)
            .padding(.horizontal)
            .padding(.horizontal)
        }
    }
}

#Preview {
    OnboardingView()
}

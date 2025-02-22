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
    
    @State private var isShowingFeedbackShareOptions = false
    
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
                        if MailComposeViewController.canSendMail {
                            isShowingFeedbackShareOptions = true
                        } else {
                            UIApplication.shared.open(URL(string: "https://www.instagram.com/j1hxna/")!)
                        }
                    } label: {
                        Text("피드백 공유")
                    }
                    .confirmationDialog(
                        "피드백 공유 방법",
                        isPresented: $isShowingFeedbackShareOptions,
                        titleVisibility: .visible,
                        actions: {
                            Button {
                                UIApplication.shared.open(URL(string: "https://www.instagram.com/j1hxna/")!)
                            } label: {
                                Text("Instagram")
                            }
                            Button {
                                MailComposeViewController.shared.sendEmail()
                            } label: {
                                Text("Mail")
                            }
                        }
                    )
                    NavigationLink {
                        AppInfoView()
                    } label: {
                        Text("앱 정보")
                    }
                }
            }
            .scrollDisabled(true)
            .navigationTitle("더보기")
        }
    }
}

#Preview {
    MoreView()
}

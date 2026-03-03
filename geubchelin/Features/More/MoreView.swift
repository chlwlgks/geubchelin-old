//
//  MoreView.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import SwiftUI

struct MoreView: View {
    @AppStorage("schoolName") private var schoolName: String?
    @AppStorage("breakfastNotificationEnabled") var breakfastNotificationEnabled: Bool = false
    @AppStorage("lunchNotificationEnabled") var lunchNotificationEnabled: Bool = false
    @AppStorage("dinnerNotificationEnabled") var dinnerNotificationEnabled: Bool = false
    
    @State private var isShowingFeedbackShareOptions = false
    private let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")!
    
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
                                    .foregroundStyle(.secondary)
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                    }
                    
                    NavigationLink("알레르기 유발 식품 선택") {
                        AllergySelectionView()
                    }
                }
                
                Section {
                    NavigationLink {
                        NotificationSettingsView()
                    } label: {
                        HStack {
                            Text("알림")
                            Spacer()
                            if breakfastNotificationEnabled || lunchNotificationEnabled || dinnerNotificationEnabled {
                                Text("켬")
                                    .foregroundStyle(.secondary)
                            } else {
                                Text("끔")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                } footer: {
                    Text("알림은 평일에만 전송됩니다.")
                }
                
                Section {
                    Button {
                        if MailComposeViewController.canSendMail {
                            isShowingFeedbackShareOptions = true
                        } else {
                            UIApplication.shared.open(URL(string: "https://www.instagram.com/j12han/")!)
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
                                UIApplication.shared.open(URL(string: "https://www.instagram.com/j12han/")!)
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
                } footer: {
                    Text("버전: \(appVersion)")
                }
            }
            .navigationTitle("더보기")
        }
    }
}

#Preview {
    MoreView()
}

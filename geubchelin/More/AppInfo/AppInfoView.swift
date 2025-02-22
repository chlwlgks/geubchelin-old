//
//  AppInfoView.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import SwiftUI

struct AppInfoView: View {
    private let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")!
    
    var body: some View {
        VStack(spacing: 10) {
            Image(uiImage: UIImage(named: "AppIcon60x60")!)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 100, height: 100)
                .padding(.top, 100)
                .padding(.bottom)
            Text("급슐랭")
                .font(.system(.largeTitle, weight: .bold))
            Text("버전 \(version)")
                .font(.callout)
            Text("© 2025 최지한. 모든 권리 보유.")
                .font(.callout)
            Spacer()
        }
        .navigationTitle("앱 정보")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AppInfoView()
}

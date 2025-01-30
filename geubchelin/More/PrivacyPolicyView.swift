//
//  PrivacyPolicyView.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import SwiftUI
import SafariServices

struct PrivacyPolicyView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let myURL = URL(string: "https://gubchelin.netlify.app")
        return SFSafariViewController(url: myURL!)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
}

#Preview {
    PrivacyPolicyView()
}

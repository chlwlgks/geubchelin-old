//
//  GADBannerView.swift
//  geubchelin
//
//  Created by 최지한 on 1/25/25.
//

import GoogleMobileAds
import SwiftUI

private struct BannerContentView: View {
    var body: some View {
        VStack {
            Spacer()
            BannerView()
                .frame(width: UIScreen.main.bounds.width, height: GADLandscapeAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width).size.height)
        }
    }
}

#Preview {
    BannerContentView()
}

struct BannerView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        // Wrap the GADBannerView in a UIView. GADBannerView automatically reloads a new ad when its
        // frame size changes; wrapping in a UIView container insulates the GADBannerView from size
        // changes that impact the view returned from makeUIView.
        let view = UIView()
        context.coordinator.bannerView.frame = CGRect(origin: .zero, size: GADLandscapeAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width).size)
        view.addSubview(context.coordinator.bannerView)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
    func makeCoordinator() -> BannerCoordinator {
        return BannerCoordinator(self)
    }
    
    class BannerCoordinator: NSObject, GADBannerViewDelegate {
        private let AdMobID = Bundle.main.infoDictionary!["AdMob ID"] as! String
        
        private(set) lazy var bannerView: GADBannerView = {
            let adSize = GADLandscapeAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width)
            
            let banner = GADBannerView(adSize: adSize)
            banner.adUnitID = AdMobID
            banner.load(GADRequest())
            banner.delegate = self
            return banner
        }()
        
        private let parent: BannerView
        
        init(_ parent: BannerView) {
            self.parent = parent
        }
        
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            // Add banner to view and add constraints.
//            addBannerViewToView(bannerView)
        }
    }
}

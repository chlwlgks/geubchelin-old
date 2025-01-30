//
//  NetworkMonitor.swift
//  geubchelin
//
//  Created by 최지한 on 1/29/25.
//

import Foundation
import Network

@Observable
final class NetworkMonitor {
    private let networkMonitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Network Monitor")
    
    var isConnected = true
    
    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        networkMonitor.start(queue: queue)
    }
}

//
//  NetworkMonitor.swift
//  Recipes
//
//  Created by Katyayani G. Raman on 8/9/24.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    var hasConnection = false

    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.hasConnection = path.status == .satisfied
            Task {
                await MainActor.run {
                    self.objectWillChange.send()
                }
            }
        }
        networkMonitor.start(queue: queue)
    }
}

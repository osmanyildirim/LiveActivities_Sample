//
//  LiveActivityAttributes.swift
//  LiveActivities_Sample
//
//  Created by osmanyildirim
//

import Foundation
import SwiftUI
import ActivityKit

/// Describes the content that appears in your Live Activity.
struct LiveActivityAttributes: ActivityAttributes {
    var courierName: String
    var courierImage: String
}

/// The dynamic data of a Live Activity that's encoded by `ContentState` can't exceed 4KB.
extension LiveActivityAttributes {
    typealias LiveData = ContentState

    struct ContentState: Codable, Hashable {
        var time: Date
        var status: OrderStatus
        var count: Int
    }
}

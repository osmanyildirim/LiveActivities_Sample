//
//  Status.swift
//  LiveActivities_Sample
//
//  Created by osmanyildirim
//

import Foundation

enum OrderStatus: Int, Codable, Hashable, CaseIterable {
    case available
    case preparing
    case onTheRoad
    case delivered
    case end

    var imageName: String {
        "\(self)"
    }

    var string: String {
        switch self {
        case .available:
            return "Available"
        case .preparing:
            return "Preparing"
        case .onTheRoad:
            return "On The Road"
        case .delivered:
            return "Delivered"
        default:
            return ""
        }
    }
}

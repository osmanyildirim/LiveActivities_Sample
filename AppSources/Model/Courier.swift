//
//  Pokemon.swift
//  LiveActivities_Sample
//
//  Created by osmanyildirim
//

import UIKit

struct Courier {
    var name: String?
    var pizzaCount: Int = 1
    var status: OrderStatus = .available

    var image: String {
        guard let name = name else { return "" }
        return name.lowercased()
    }

    mutating func updateStatus(_ value: Int) {
        status = OrderStatus(rawValue: value) ?? .available
    }
    
    mutating func updatePizzaCount(_ value: Int) {
        pizzaCount = value == 0 ? 1 : value
    }

    mutating func incrementPizzaCount() {
        pizzaCount += 1
    }
}

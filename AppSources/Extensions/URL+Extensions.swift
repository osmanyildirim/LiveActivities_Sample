//
//  URL+Extensions.swift
//  LiveActivities_Sample
//
//  Created by osmanyildirim
//

import Foundation

extension URL {
    /// `url.queryItems` → output → [key : "lang" value : "en"]
    var queryItems: [String: Any] {
        var items: [String: Any] = [:]
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else { return items }
        queryItems.forEach { items[$0.name] = $0.value }
        return items
    }
}

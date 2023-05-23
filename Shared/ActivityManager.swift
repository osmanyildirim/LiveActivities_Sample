//
//  ActivityManager.swift
//  LiveActivities_Sample
//
//  Created by osmanyildirim
//

import Foundation
import ActivityKit

@available(iOS 16.1, *)
final class ActivityManager {
    /// Requests and starts a Live Activity.
    /// - Parameters:
    ///   - courierName: courier name
    ///   - courierImage: courier image name
    ///   - count: pizza count
    ///   - pushType: A value that indicates whether the Live Activity receives updates to its dynamic content with ActivityKit push notifications
    /// `pushType`'s default is value is: `token: To start a Live Activity that receives updates to its dynamic content with ActivityKit push notifications`
    func start(courierName: String, courierImage: String, count: Int, pushType: PushType? = .token) async {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            for await enablment in ActivityAuthorizationInfo().activityEnablementUpdates {
                print("Live Activities AuthorizationInfo is \(enablment)")
            }
            return
        }

        let attributes = LiveActivityAttributes(courierName: courierName, courierImage: courierImage)
        let state = LiveActivityAttributes.ContentState(time: Date(), status: .preparing, count: count)

        _ = try? Activity.request(attributes: attributes, contentState: state, pushType: pushType)
    }
    
    /// Updates the dynamic content of a Live Activity and alerts the user about the Live Activity update.
    /// - Parameters:
    ///   - status: status of order
    ///   - count: pizza count
    func update(status: OrderStatus, count: Int) {
        guard let current = Activity<LiveActivityAttributes>.activities.first else {
            return
        }

        let state = LiveActivityAttributes.ContentState(time: Date(), status: status, count: count)
        let alertConfiguration = AlertConfiguration(title: "", body: "", sound: .default)

        Task {
            await current.update(using: state, alertConfiguration: alertConfiguration)
        }
    }
    
    /// Ends an active Live Activity by courierName. Find activity to be end from activity list by courierName.
    /// - Parameters:
    ///   - courierName: courier name
    ///   - dismissalPolicy: Describes how and when the system should dismiss a Live Activity and and remove it from the Lock Screen.
    /// `dismissalPolicy`'s default is value is: `immediate: The system immediately removes the Live Activity that ended.`
    func end(courierName: String?, dismissalPolicy: ActivityUIDismissalPolicy = .immediate) {
        guard let courierName, let activity = Activity<LiveActivityAttributes>.activities.first(where: { $0.attributes.courierName == courierName }) else { return }

        Task {
            await activity.end(dismissalPolicy: dismissalPolicy)
        }
    }

    /// End Live Activities.
    /// The system immediately removes all Live Activities that has ended.
    /// - Parameter dismissalPolicy: Describes how and when the system should dismiss a Live Activity and and remove it from the Lock Screen.
    /// `dismissalPolicy`'s default is value is: `immediate: The system immediately removes the Live Activity that ended.`
    func endAll(dismissalPolicy: ActivityUIDismissalPolicy = .immediate) {
        Activity<LiveActivityAttributes>.activities.forEach { activity in
            Task {
                await activity.end(dismissalPolicy: dismissalPolicy)
            }
        }
    }
}

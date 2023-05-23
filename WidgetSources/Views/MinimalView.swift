//
//  MinimalView.swift
//  LiveActivities_WidgetExtension
//
//  Created by osmanyildirim
//

import ActivityKit
import SwiftUI
import WidgetKit

/// View for the minimal presentation of the Live Activity.
struct MinimalView: View {
    var context: ActivityViewContext<LiveActivityAttributes>
    var body: some View {
        Image(context.state.status.imageName)
            .resizable()
            .frame(width: 30, height: 30)
    }
}

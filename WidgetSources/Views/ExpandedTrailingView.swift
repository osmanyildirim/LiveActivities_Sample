//
//  ExpandedTrailingView.swift
//  LiveActivities_WidgetExtension
//
//  Created by osmanyildirim
//

import ActivityKit
import SwiftUI
import WidgetKit

/// View for the along the trailing edge of the expanded Live Activity next to the TrueDepth camera and wraps additional content below it.
struct ExpandedTrailingView: View {
    var context: ActivityViewContext<LiveActivityAttributes>
    var body: some View {
        Label {
            Text(context.state.time, style: .timer)
                .frame(width: 60)
        } icon: {
            Image(systemName: "timer")
                .foregroundColor(.gray)
        }
        .font(.headline)
    }
}

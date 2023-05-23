//
//  CompactTrailingView.swift
//  LiveActivities_WidgetExtension
//
//  Created by osmanyildirim
//

import ActivityKit
import SwiftUI
import WidgetKit

/// View for the compact trailing presentation of the Live Activity.
struct CompactTrailingView: View {
    var context: ActivityViewContext<LiveActivityAttributes>
    var body: some View {
        Text(context.state.time, style: .timer)
            .frame(width: 40)
            .font(.title)
    }
}

//
//  ExpandedLeadingView.swift
//  LiveActivities_WidgetExtension
//
//  Created by osmanyildirim
//

import ActivityKit
import SwiftUI
import WidgetKit

/// View for the along the leading edge of the expanded Live Activity next to the TrueDepth camera and wraps additional content below it.
struct ExpandedLeadingView: View {
    var context: ActivityViewContext<LiveActivityAttributes>
    var body: some View {
        VStack {
            Text("\(context.state.count) Pizzas")
                .font(.headline)

            Label {
                Text("\(context.state.status.string)")
            } icon: {
                Image(context.state.status.imageName)
                    .resizable()
                    .frame(width: 25, height: 25)
            }
                .font(.caption)
        }
    }
}

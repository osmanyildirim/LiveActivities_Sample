//
//  CompactLeadingView.swift
//  LiveActivities_WidgetExtension
//
//  Created by osmanyildirim
//

import ActivityKit
import SwiftUI
import WidgetKit

/// View for the compact leading presentation of the Live Activity.
struct CompactLeadingView: View {
    var context: ActivityViewContext<LiveActivityAttributes>
    var body: some View {
        HStack {
            Label {
                Text("\(context.attributes.courierName)")
            } icon: {
                Image(context.attributes.courierImage)
                    .resizable()
                    .frame(width: 25, height: 25)
            }
            .font(.title)
        }
    }
}

//
//  ExpandedCenterView.swift
//  LiveActivities_WidgetExtension
//
//  Created by osmanyildirim
//

import ActivityKit
import SwiftUI
import WidgetKit

/// View for the below the TrueDepth camera.
struct ExpandedCenterView: View {
    var context: ActivityViewContext<LiveActivityAttributes>
    var body: some View {
        Label {
            Text("\(context.attributes.courierName)")
        } icon: {
            Image(context.attributes.courierImage)
                .resizable()
                .frame(width: 40, height: 40)
        }
    }
}

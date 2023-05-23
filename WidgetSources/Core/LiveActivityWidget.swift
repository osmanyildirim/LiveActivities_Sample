//
//  LiveActivityWidget.swift
//  LiveActivities_WidgetExtension
//
//  Created by osmanyildirim
//

import ActivityKit
import SwiftUI
import WidgetKit

/// LiveActivityWidget describes a widget's content.
/// `keylineTint`: Applies a subtle tint color to the surrounding border of a Live Activity that appears in the Dynamic Island.
struct LiveActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivityAttributes.self) { context in
            LockScreenView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    ExpandedLeadingView(context: context)
                }

                DynamicIslandExpandedRegion(.trailing) {
                    ExpandedTrailingView(context: context)
                }

                DynamicIslandExpandedRegion(.center) {
                    ExpandedCenterView(context: context)
                }

                DynamicIslandExpandedRegion(.bottom) {
                    ExpandedBottomView()
                }

            } compactLeading: {
                CompactLeadingView(context: context)
            } compactTrailing: {
                CompactTrailingView(context: context)
            } minimal: {
                MinimalView(context: context)
            }.keylineTint(Color("HokeyPokey"))
        }
    }
}

/// `LockScreen`, `ExpandedLeading`, `ExpandedTrailing`, `ExpandedCenter`, `ExpandedBottom`, `CompactLeading`, `CompactTrailing` and `Minimal` previews
struct LiveActivityWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            if #available(iOSApplicationExtension 16.2, *) {
                LiveActivityAttributes(courierName: "Luis",
                                       courierImage: "luis")
                .previewContext(.init(time: Date(),
                                      status: .onTheRoad,
                                      count: 2),
                                viewKind: .content)
                
                LiveActivityAttributes(courierName: "Luis",
                                       courierImage: "luis")
                .previewContext(.init(time: Date(),
                                      status: .onTheRoad,
                                      count: 2),
                                viewKind: .dynamicIsland(.expanded))
                
                LiveActivityAttributes(courierName: "Luis",
                                       courierImage: "luis")
                .previewContext(.init(time: Date(),
                                      status: .onTheRoad,
                                      count: 2),
                                viewKind: .dynamicIsland(.compact))
                
                LiveActivityAttributes(courierName: "Luis",
                                       courierImage: "luis")
                .previewContext(.init(time: Date(),
                                      status: .onTheRoad,
                                      count: 2),
                                viewKind: .dynamicIsland(.minimal))
                
            }
        }
    }
}

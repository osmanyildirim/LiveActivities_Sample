//
//  ExpandedBottomView.swift
//  LiveActivities_WidgetExtension
//
//  Created by osmanyildirim
//

import ActivityKit
import SwiftUI
import WidgetKit

/// View for the below leading, trailing, and center content.
struct ExpandedBottomView: View {
    var body: some View {
        let url = URL(string: "liveactivitiessample://?phone=9988")

        return HStack {
            Link(destination: url!) {
                Label {
                    Text("Call")
                } icon: {
                    Image(systemName: "phone.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                .font(.title3)
            }.foregroundColor(.yellow)
        }.padding([.vertical], 20)
    }
}

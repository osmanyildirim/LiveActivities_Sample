//
//  LockScreenView.swift
//  LiveActivities_WidgetExtension
//
//  Created by osmanyildirim
//

import ActivityKit
import SwiftUI
import WidgetKit

/// View for the Live Activity that appears on the Lock Screen.
/// This view also appears as a banner on the Home Screen of devices that don't support the Dynamic Island when you alert a person about updated Live Activity content.
struct LockScreenView: View {
    var context: ActivityViewContext<LiveActivityAttributes>
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                Text("\(context.state.count) Pizzas")
                    .padding(.leading, 5)
                    .font(.headline)
                Spacer()
                
                HStack {
                    Image(context.attributes.courierImage)
                        .resizable()
                        .frame(width: 40, height: 40)

                    Text(context.attributes.courierName)
                        .font(.headline)

                }
                .padding(.leading, 5)

                Spacer()

                Label {
                    Text(context.state.time, style: .timer)
                        .frame(width: 60)
                } icon: {
                    Image(systemName: "timer")
                        .foregroundColor(.gray)
                }
                .font(.headline)
            }

            HStack {
                ZStack {
                    let dividerColor = colorScheme == .dark ? Color("HokeyPokey") : Color("StoneCold")
                    
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(style: StrokeStyle(lineWidth: 1,
                                                   dash: [2]))
                    
                        .frame(height: 5)
                        .foregroundColor(dividerColor.opacity(0.5))
                        .padding(.leading, 10)
                        .padding(.trailing, 10)

                    HStack {
                        ForEach([OrderStatus.available,
                                 OrderStatus.preparing,
                                 OrderStatus.onTheRoad,
                                 OrderStatus.delivered], id: \.self) { state in
                            let color = context.state.status == state ? Color("HokeyPokey") : Color("DustyGray")
                            let size: CGFloat = context.state.status == state ? 50 : 40

                            VStack {
                                Rectangle()
                                    .foregroundColor(color)
                                    .clipShape(Circle())
                                    .frame(width: size, height: size)
                                    .overlay(
                                    Image(state.imageName)
                                        .resizable()
                                        .frame(width: size - 15, height: size - 15)
                                        .foregroundColor(.blue)
                                ).padding(.trailing, 25)
                            }
                        }
                    }
                }
            }.padding(.top, 8)
        }.padding(10)
    }
}

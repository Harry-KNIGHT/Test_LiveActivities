//
//  Timer_Widget.swift
//  Timer_Widget
//
//  Created by Elliot Knight on 02/11/2022.
//
import ActivityKit
import WidgetKit
import SwiftUI


struct Timer_Widget: Widget {
	var body: some WidgetConfiguration {
		ActivityConfiguration(for: TimeTrackingAttributes.self) { context in
			TimeTrackingWidgetView(context: context)
		} dynamicIsland: { context in
			DynamicIsland {
					DynamicIslandExpandedRegion(.leading) {
						Image(systemName: "hare.fill")
						Text("7km")
							.font(.title3)
							.fontWeight(.semibold)
						Text("8km/min")
						Text("13km/h")
					}


				DynamicIslandExpandedRegion(.trailing) {
					VStack {
						Spacer()
						Text(context.state.startTimer, style: .timer)
						Spacer()
					}

				}
			} compactLeading: {
				Image(systemName: "hare.fill")

			} compactTrailing: {
				TimeTrackingWidgetView(context: context)
			} minimal: {
				Image(systemName: "hare.fill")

			}

		}

	}
}


struct TimeTrackingWidgetView: View {
	let context: ActivityViewContext<TimeTrackingAttributes>
	var body: some View {
		VStack {
			Text(context.state.startTimer, style: .timer)
		}
		.padding()
	}
}

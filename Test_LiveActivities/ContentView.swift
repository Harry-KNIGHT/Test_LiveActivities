//
//  ContentView.swift
//  Test_LiveActivities
//
//  Created by Elliot Knight on 02/11/2022.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
	@State private var isStrackingTime: Bool = false
	@State private var startTime: Date? = nil
	@State private var activity: Activity<TimeTrackingAttributes>? = nil

	// Speed value
	@State private var speed = 1
	var timer = Timer.publish(every: 1.0, on: .main, in: .default).autoconnect()
	@Environment(\.scenePhase) var scenPhase
	var body: some View {
		NavigationStack {
			VStack {
				if let startTime = startTime {
					Text(startTime, style: .timer)
				}
				Text("Speed = \(speed)")
				Button {
					isStrackingTime.toggle()
					if isStrackingTime {
						startTime = .now
						// Start live ativity
						
						let attribute = TimeTrackingAttributes()
						let state = TimeTrackingAttributes.ContentState(startTimer: .now, speed: speed)

						activity = try? Activity<TimeTrackingAttributes>.request(attributes: attribute, contentState: state, pushType: nil)
					} else {
						// Stop live activity
						guard let startTime else { return  }
						let state = TimeTrackingAttributes.ContentState(startTimer: startTime, speed: speed)

						Task {
							await activity?.end(using: state, dismissalPolicy: .immediate)
						}
						self.startTime = nil
					}
				} label: {
					Text(isStrackingTime ? "Stop" : "Start")
				}
				.buttonStyle(.borderedProminent)
				.tint(isStrackingTime ? .red : .green)
			}
			.onChange(of: Date.now) { _ in
				speed = Int.random(in: 1...10)
				Task {
					if let activity = activity, let startTime {
						await activity.update(using: .init(startTimer: startTime, speed: speed))
					}
				}
			}
			.padding()
			.navigationTitle("Basic timer")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

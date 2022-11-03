//
//  TimeTrackingAttributes.swift
//  Test_LiveActivities
//
//  Created by Elliot Knight on 02/11/2022.
//

import ActivityKit
import Foundation

struct TimeTrackingAttributes: ActivityAttributes {
	public typealias timeTrackingStatus = ContentState

	struct ContentState: Codable, Hashable {
		var startTimer: Date
		var speed: Int
	}
	
}

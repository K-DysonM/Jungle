//
//  WorkoutViewModel.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/6/22.
//

import Foundation


class WorkoutViewModel {
	
	@Published var workouts: [[SetViewModel]]  = []
	
	init() {
		var sampleData: [[SetViewModel?]] = Array(repeating: Array(repeating: nil, count: 5), count: 5)
		
		for row in 0..<5 {
			for col in 0..<5 {
				let temp_set = WorkoutSet(order: col, weight: 10, reps: 12)
				sampleData[row][col] = SetViewModel(set: temp_set)
			}
		}
		
		workouts =  sampleData as! [[SetViewModel]]
	}
	
	func updateOrderForWorkout(_ section: Int) {
		let rows = workouts[section]
		for set in 0..<rows.count {
			rows[set].numberOrder = (set + 1)
		}
	}
	
	func addSetForWorkout(_ section: Int) {
		let row = workouts[section].count
		let newSetViewModel = SetViewModel(set: WorkoutSet(order: row, weight: 10, reps: 20))
		workouts[section].append(newSetViewModel)
	}
}

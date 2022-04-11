//
//  WorkoutViewModel.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/6/22.
//

import Foundation


class WorkoutVM {
	//Talk about why you made it a list of structs vs a dictionary
	@Published var workoutExercises: [WorkoutExercise] = []
	
	var date: Date?
	init(workoutExercises: [WorkoutExercise]) {
		self.workoutExercises = workoutExercises
	}
	
	init() {
		var sampleData: [[SetVM?]] = Array(repeating: Array(repeating: nil, count: 5), count: 5)
		
		for row in 0..<5 {
			for col in 0..<5 {
				let temp_set = WorkoutSet(order: col, weight: 10, reps: 12)
				sampleData[row][col] = SetVM(set: temp_set)
			}
		}
	}
	
	func updateOrderForWorkout(_ section: Int) {
		let rows = workoutExercises[section].sets
		for set in 0..<rows.count {
			rows[set].numberOrder = (set + 1)
		}
	}
	
	func addSetForWorkout(_ section: Int) {
		let row = workoutExercises[section].sets.count
		let newSetViewModel = SetVM(set: WorkoutSet(order: row, weight: 10, reps: 20))
		workoutExercises[section].sets.append(newSetViewModel)
		updateOrderForWorkout(section)
	}
	
	func addExerciseToWorkout(_ exercise: ExerciseVM) {
		let workoutExercise = WorkoutExercise(exercise: exercise, sets: [])
		workoutExercises.append(workoutExercise)
		print(#function)
	}
	
	func getExerciseForSection(_ section: Int) -> ExerciseVM {
		workoutExercises[section].exercise
	}
	func getSetForExercise(section: Int, row: Int) -> SetVM {
		workoutExercises[section].sets[row]
	}
	
	func getFirst() -> String {
		let order = workoutExercises.first?.sets.first?.numberOrder ?? 999
		let detail = workoutExercises.first?.exercise.name ?? "Unavailable"
		return "\(order): " + detail
	}
	
	func string() -> String {
		var description = ""
		
		workoutExercises.forEach { workoutExercise in
			description += workoutExercise.exercise.name
		}
		return description
	}
	
	func removeSetForExercise(section: Int, row: Int) {
		workoutExercises[section].sets.remove(at: row)
		updateOrderForWorkout(section)
	}
}
struct WorkoutExercise {
	var exercise : ExerciseVM
	var sets : [SetVM]
}





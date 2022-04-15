//
//  SetViewModel.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/6/22.
//

import Foundation

class SetVM {
	
	private var set: WorkoutSet
	
	@Published var date: Date? = nil
	@Published var numberOrder: Int
	@Published var isDone: Bool
	@Published var weight: Double
	@Published var reps: Int
	
	init(set: WorkoutSet) {
		self.set = set
		numberOrder = set.order + 1 // Set is a model that is 0 indexed but visually we want to show 1 indexed
		isDone = set.isDone
		weight = set.weight
		reps = set.reps
	}
	init(history: SetEntity) {
		let workout_set = WorkoutSet(order: Int(history.order), weight: history.weight, reps: Int(history.reps))
		self.set = workout_set
		date = history.parentExercise?.workout?.date
		numberOrder = set.order + 1 // Set is a model that is 0 indexed but visually we want to show 1 indexed
		isDone = set.isDone
		weight = set.weight
		reps = set.reps
	}
	
	@objc func toggle(){
		isDone.toggle()
	}
	
	func updateReps(for reps: Int) {
		self.reps = reps
	}
	func updateWeight(for weight: Double) {
		self.weight = weight
	}
	
}
extension SetVM: NSCopying {
	func copy(with zone: NSZone? = nil) -> Any {
		let copy = SetVM(set: set)
		return copy
	}
}

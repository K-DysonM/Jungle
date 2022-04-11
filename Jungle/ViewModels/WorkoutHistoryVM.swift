//
//  WorkoutHistoryViewModel.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/9/22.
//

import Foundation
import Combine

class WorkoutHistoryVM {
	
	private let coreDataUtil = CoreDataUtil()
	
	@Published var workoutHistory: [WorkoutVM] = []
	
	var exercises: [Exercise] = []
	
	init() {
		loadExerciseFile()
	}
	
	func getWorkoutHistory() {
		coreDataUtil.fetchWorkouts { workouts, error in
			guard error == nil else { print(error ?? "Error getting workouts"); return }
			guard let workouts = workouts else {
				return
			}
			let workoutVMs = workouts.compactMap({
				self.getWorkoutViewModel(entity: $0)
			})
			self.workoutHistory = workoutVMs

		}
	}
	func clearHistory() {
		coreDataUtil.clearDatabase()
	}
	
	func getWorkoutViewModel( entity: WorkoutEntity) -> WorkoutVM{
		let exercises = entity.exercises as! Set<ExerciseEntity>
		let workoutExercises = exercises.compactMap {
			getWorkoutExercise(entity: $0)
		}
		
		let workoutVm = WorkoutVM(workoutExercises: workoutExercises)
		workoutVm.date = entity.date
		return workoutVm
	}
	private func getWorkoutExercise(entity: ExerciseEntity) -> WorkoutExercise?{
		guard let exercise = getExerciseById(Int(entity.exercise_ID)) else { return nil }
		let sets = entity.sets as! Set<SetEntity>
		var setViewModels: [SetVM] = []
		sets.forEach { setEntity in
			let workoutSet = WorkoutSet(order: Int(setEntity.order), weight: setEntity.weight, reps: Int(setEntity.reps))
			let newVM = SetVM(set: workoutSet)
			setViewModels.append(newVM)
		}
		
		return WorkoutExercise(exercise: ExerciseVM(exercise: exercise), sets: setViewModels)
	}
		
	func getExerciseById(_ id: Int) -> Exercise?{
		exercises.first { $0.id == id }
	}
				
				
				
	// Load all exercises
	func loadExerciseFile() {
		let decorder = JSONDecoder()
		
		if let filePath = Bundle.main.path(forResource: "Exercises", ofType: "json") {
			guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else { return }
			do {
				let fileContent = try decorder.decode([Exercise].self, from: data)
				self.exercises = fileContent
				self.getWorkoutHistory()
			} catch  {
				print(error)
			}
			
		} else {
			print("Invalid filepath")
		}
	}
				
	
}

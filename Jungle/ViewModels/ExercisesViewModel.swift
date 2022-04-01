//
//  ExercisesViewModel.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/1/22.
//

import Foundation
import Combine

class ExercisesViewModel {
	//@Published var exercises: [ExerciseViewModel] = []
	
	@Published var exercisesDict: [String: [ExerciseViewModel]] = [:] {
		didSet {
			exercisesOrder = exercisesDict.keys.sorted()
		}
	}
	@Published var exercisesOrder: [String] = []
	
	init() {
		loadExerciseFile()
	}
	
	
	// Load all exercises
	func loadExerciseFile() {
		let decorder = JSONDecoder()
		
		if let filePath = Bundle.main.path(forResource: "Exercises", ofType: "json") {
			guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else { return }
			do {
				let fileContent = try decorder.decode([Exercise].self, from: data)
				
				fileContent.forEach { exercise in
					let exerciseViewModel = ExerciseViewModel(exercise: exercise)
					if let firstChar = exercise.name.first {
						if exercisesDict[String(firstChar)] != nil {
							exercisesDict[String(firstChar)]!.append(exerciseViewModel)
						} else {
							exercisesDict[String(firstChar)] = [exerciseViewModel]
						}
					}
				}
				
			} catch  {
				print(error)
			}
			
		} else {
			print("Invalid filepath")
		}
	}
}

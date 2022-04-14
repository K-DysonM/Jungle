//
//  TemplateVM.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/10/22.
//

import Foundation

struct Template {
	var template_id: UUID
	var name: String
	var workoutVM: WorkoutVM
}

class TemplateVM {
	
	private let coreDataUtil = CoreDataUtil()
	
	@Published var templates: [Template] = []
	
	var exercises: [Exercise] = []
	
	init() {
		loadExerciseFile()
	}
	
	func getWorkoutHistory() {
		coreDataUtil.fetchTemplates { workouts, error in
			guard error == nil else { print(error ?? "Error getting workouts"); return }
			guard let workouts = workouts else {
				return
			}
			let workoutVMs = workouts.compactMap({
				self.getWorkoutViewModel(entity: $0)
			})
			self.templates = workoutVMs
			
		}
	}
	func clearHistory() {
		coreDataUtil.clearDatabase()
	}
	func deleteTemplate(_ template: Template) {
		coreDataUtil.deleteTemplate(template_id: template.template_id)
	}
	
	func getWorkoutViewModel( entity: TemplateEntity) -> Template{
		let exercises = entity.exercises as! Set<ExerciseEntity>
		let workoutExercises = exercises.compactMap {
			getWorkoutExercise(entity: $0)
		}
		
		let workoutVm = WorkoutVM(workoutExercises: workoutExercises, withName: entity.name!)
		let template = Template(template_id: entity.template_ID!, name: entity.name!, workoutVM: workoutVm)
		return template
	}
	private func getWorkoutExercise(entity: ExerciseEntity) -> WorkoutExercise?{
		guard let exercise = getExerciseById(Int(entity.exercise_ID)) else { return nil }
		let sets = entity.sets as! Set<SetEntity>
		var setViewModels: [SetVM?] = Array(repeating: nil, count: sets.count)
		sets.forEach { setEntity in
			let workoutSet = WorkoutSet(order: Int(setEntity.order)-1, weight: setEntity.weight, reps: Int(setEntity.reps))
			let newVM = SetVM(set: workoutSet)
			setViewModels[Int(setEntity.order)-1] = newVM
		}
		let nonNilSetVMs = setViewModels.compactMap { $0 }
		
		return WorkoutExercise(exercise: ExerciseVM(exercise: exercise), sets: nonNilSetVMs)
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

//
//  CoreDataUtil.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/5/22.
//

import Foundation
import CoreData
import UIKit

class CoreDataUtil {
	private var managedObjectContext: NSManagedObjectContext!
	
	init() {
		managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	}
	
	func fetchHistoryForExerciseID(_ id: Int, completionHandler: @escaping ([HistoryEntity]?, Error?) -> Void) {
		let fetchRequest = HistoryEntity.fetchRequest()
		fetchRequest.sortDescriptors =
		[
			NSSortDescriptor(keyPath: \HistoryEntity.date, ascending: false),
		]
		
		fetchRequest.predicate = NSPredicate(
			format: "exercise_ID == %d", Int64(id)
		)
		do {
			let results = try managedObjectContext.fetch(fetchRequest)
			completionHandler(results, nil)
		} catch {
			completionHandler(nil, error)
		}
	}
	
	func postTemplate(for workoutData: [WorkoutExercise], named name: String) {
		let template = TemplateEntity(context: managedObjectContext)
		template.template_ID = UUID()
		template.name = name
		
		workoutData.forEach { data in
			let exercise = ExerciseEntity(context: managedObjectContext)
			exercise.exercise_ID = Int64(data.exercise.getExerciseId())
			exercise.template = template
			
			data.sets.forEach { setForExercise in
				let setEntity = SetEntity(context: managedObjectContext)
				setEntity.parentExercise = exercise
				setEntity.weight = setForExercise.weight
				setEntity.reps = Int16(setForExercise.reps)
				setEntity.order = Int16(setForExercise.numberOrder)
				exercise.addToSets(setEntity)
			}
			template.addToExercises(exercise)
		}
		do {
			try managedObjectContext.save()
		} catch {
			print(error)
		}
	}
	
	
	func postWorkout(for workoutData: [WorkoutExercise]) {
		let workout = WorkoutEntity(context: managedObjectContext)
		workout.date = Date()
		workout.workout_ID = UUID()
		
		workoutData.forEach { data in
			let exercise = ExerciseEntity(context: managedObjectContext)
			exercise.exercise_ID = Int64(data.exercise.getExerciseId())
			exercise.workout = workout
			
			data.sets.forEach { setForExercise in
				let setEntity = SetEntity(context: managedObjectContext)
				setEntity.parentExercise = exercise
				setEntity.weight = setForExercise.weight
				setEntity.reps = Int16(setForExercise.reps)
				setEntity.order = Int16(setForExercise.numberOrder)
				exercise.addToSets(setEntity)
			}
			workout.addToExercises(exercise)
		}
		
		do {
			try managedObjectContext.save()
		} catch {
			print(error)
		}
	}
	func fetchWorkouts(completionHandler: @escaping ([WorkoutEntity]?, Error?) -> Void) {
		let fetchRequest = WorkoutEntity.fetchRequest()
		
		do {
			let results = try managedObjectContext.fetch(fetchRequest)
			completionHandler(results, nil)
		} catch {
			completionHandler(nil, error)
		}
	}
	func fetchTemplates(completionHandler: @escaping ([TemplateEntity]?, Error?) -> Void) {
		let fetchRequest = TemplateEntity.fetchRequest()
		
		do {
			let results = try managedObjectContext.fetch(fetchRequest)
			completionHandler(results, nil)
		} catch {
			completionHandler(nil, error)
		}
	}
	
	
	
	func postHistoryRandom(){
		let history = HistoryEntity(context: managedObjectContext)
		
		history.exercise_ID = Int64.random(in: 1...6)
		history.best_set = Int16.random(in: 30...90)
		let date1 = Date.parse("2019-02-01")
		let date2 = Date.parse("2019-04-01")
		let new_date =  Date.randomBetween(start: date1, end: date2)
		history.date = new_date
		do {
			try managedObjectContext.save()
		} catch {
			print(error)
		}
	}
	
	func clearDatabase() {
		let persistentStoreCoordinator = managedObjectContext.persistentStoreCoordinator
		guard let url =  persistentStoreCoordinator?.persistentStores.first?.url else { return }
		do {
			try persistentStoreCoordinator!.destroyPersistentStore(at:url, ofType: NSSQLiteStoreType, options: nil)
			try persistentStoreCoordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
		} catch {
			print("Attempted to clear persistent store: " + error.localizedDescription)
		}
	}
}

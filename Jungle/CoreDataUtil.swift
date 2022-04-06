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
	private var manageObjectContext: NSManagedObjectContext!
	
	init() {
		manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
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
			let results = try manageObjectContext.fetch(fetchRequest)
			completionHandler(results, nil)
		} catch {
			completionHandler(nil, error)
		}
	}
	
	func postHistoryRandom(){
		let history = HistoryEntity(context: manageObjectContext)
		
		history.exercise_ID = Int64.random(in: 1...6)
		history.best_set = Int16.random(in: 30...90)
		let date1 = Date.parse("2019-02-01")
		let date2 = Date.parse("2019-04-01")
		let new_date =  Date.randomBetween(start: date1, end: date2)
		history.date = new_date
		do {
			try manageObjectContext.save()
		} catch {
			print(error)
		}
	}
}

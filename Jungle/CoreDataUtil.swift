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
	var manageObjectContext: NSManagedObjectContext!
	
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
}

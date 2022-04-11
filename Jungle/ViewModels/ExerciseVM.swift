//
//  ExerciseViewModel.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/1/22.
//

import Foundation
import Combine
import Charts

class ExerciseVM {
	private var exercise: Exercise
	
	@Published var name: String
	@Published var bodyPart: String
	@Published var lastSet: String
	@Published var image: String
	@Published var history: [HistoryVM]
	
	init(exercise: Exercise) {
		self.exercise = exercise
		self.name = exercise.name
		self.bodyPart = exercise.body_part
		self.lastSet = exercise.history
		self.image = exercise.image
		
		history = []
		loadHistory()
	}
	func getExerciseId() -> Int {
		return exercise.id
	}
	
	// Fetches history for current exercise from core data
	func loadHistory() {
		let coreDataUtil = CoreDataUtil()
		coreDataUtil.fetchHistoryForExerciseID(exercise.id) { result, error in
			guard error == nil else { return }
			guard let result = result else { return }
			
			let models = result.compactMap {
				HistoryVM(history: $0)
			}
			self.history = models
		}
	}
	
	func getChartData() -> [ChartDataEntry] {
		var chartData: [ChartDataEntry] = history.compactMap { history in
			if let timeInterval = history.history.date?.timeIntervalSince1970 {
				let temp = ChartDataEntry(x: timeInterval, y: Double(history.history.best_set))
				return temp
			} else {
				return nil
			}
		}
		chartData.sort {
			$0.x < $1.x
		}
		return chartData
	}
	
}

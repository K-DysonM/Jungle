//
//  ExerciseViewModel.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/1/22.
//

import Foundation
import Combine
import Charts

class ExerciseViewModel {
	private var exercise: Exercise
	
	@Published var name: String
	@Published var bodyPart: String
	@Published var lastSet: String
	@Published var image: String
	@Published var history: [HistoryViewModel]
	
	init(exercise: Exercise) {
		self.exercise = exercise
		self.name = exercise.name
		self.bodyPart = exercise.body_part
		self.lastSet = exercise.history
		self.image = exercise.image
		
		var temp: [HistoryViewModel] = []
		for _ in 1...5 {
			temp.append(HistoryViewModel())
		}
		temp.sort {
			$0.history.time.timeIntervalSince1970 > $1.history.time.timeIntervalSince1970
		}
		self.history = temp
	}
	
	func getChartData() -> [ChartDataEntry] {
		var chartData: [ChartDataEntry] = []
		history.forEach { history in
			let temp = ChartDataEntry(x: history.history.time.timeIntervalSince1970, y: Double(history.history.best))
			chartData.append(temp)
		}
		chartData.sort {
			$0.x < $1.x
		}
		return chartData
	}
	
}

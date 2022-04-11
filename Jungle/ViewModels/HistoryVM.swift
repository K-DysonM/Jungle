//
//  HistoryViewModel.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/3/22.
//

import Foundation

class HistoryVM {
	var history: HistoryEntity
	
	var time: String
	var bestSet: String
	
	init(history: HistoryEntity) {
		self.history = history
		
		if let date = history.date?.dateString("EEEE, MMMM dd YYYY") {
			self.time = date
		} else {
			self.time = "unavailable"
		}
		self.bestSet = String(history.best_set)
	}
}

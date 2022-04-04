//
//  HistoryViewModel.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/3/22.
//

import Foundation

class HistoryViewModel {
	var history: History
	
	var time: String
	var bestSet: String
	
	init(history: History = History(time: Date(), best: 40)) {
		self.history = history
		// Convert date to string
		let date1 = Date.parse("2019-02-01")
		let date2 = Date.parse("2019-04-01")
		let new_date =  Date.randomBetween(start: date1, end: date2)
		
		let best = Int.random(in: 30...90)
		self.history = History(time: new_date, best: best)
		self.time = new_date.dateString("EEEE, MMMM dd YYYY")
		self.bestSet = String(best)
	}
}

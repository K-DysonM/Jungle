//
//  SetViewModel.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/6/22.
//

import Foundation

class SetViewModel {
	
	private var set: WorkoutSet
	
	@Published var numberOrder: Int
	@Published var isDone: Bool
	@Published var weight: Int
	@Published var reps: Int
	
	init(set: WorkoutSet) {
		self.set = set
		numberOrder = set.order + 1 // Set is a model that is 0 indexed but visually we want to show 1 indexed
		isDone = set.isDone
		weight = set.weight
		reps = set.reps
	}
	
	@objc func toggle(){
		isDone.toggle()
	}
	
}

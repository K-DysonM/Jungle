//
//  ExerciseViewModel.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/1/22.
//

import Foundation
import Combine

class ExerciseViewModel {
	private var exercise: Exercise
	
	@Published var name: String
	@Published var bodyPart: String
	@Published var lastSet: String
	@Published var image: String
	
	init(exercise: Exercise) {
		self.exercise = exercise
		self.name = exercise.name
		self.bodyPart = exercise.body_part
//		switch exercise.body_part {
//		case .Arms:
//			self.bodyPart = "Arms"
//		case .Back:
//			self.bodyPart = "Back"
//		case .Chest:
//			self.bodyPart = "Chest"
//		case .Core:
//			self.bodyPart = "Core"
//		case .Legs:
//			self.bodyPart = "Legs"
//		case .Shoulders:
//			self.bodyPart = "Shoulders"
//		default: //Leaving in case we add more body parts down the line
//			self.bodyPart = "Other"
//		}
		self.lastSet = exercise.history
		self.image = exercise.image
	}
	
}

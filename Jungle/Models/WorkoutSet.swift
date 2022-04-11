//
//  Set.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/6/22.
//

import Foundation

struct WorkoutSet: Codable {
	var order: Int
	var isDone: Bool = false
	var weight: Double
	var reps: Int
}

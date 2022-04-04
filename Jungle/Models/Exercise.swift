//
//  Exercise.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/1/22.
//

import Foundation

struct Exercise: Codable {
	var name: String
	var body_part: String
	var history: String
	var image: String
	var history_set: [History]? = []
}

struct History: Codable {
	var time: Date
	var best: Int
}

enum BodyPart: Codable {
	case Back
	case Legs
	case Shoulders
	case Chest
	case Core
	case Arms
}

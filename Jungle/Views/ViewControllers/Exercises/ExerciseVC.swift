//
//  ExerciseVC.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/8/22.
//

import Foundation
import UIKit

class ExerciseVC: UIViewController {
	var exerciseTableVC: ExerciseTableVC = {
		let tableVC = ExerciseTableVC()
		return tableVC
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		exerciseTableVC.exerciseTableViewDelegate = self
		let navController = UINavigationController(rootViewController: exerciseTableVC)
		addContainerVC(navController)
	}
	/* Primary ViewDidLoad methods */
	func addContainerVC (_ vc: UIViewController) {
		addChild(vc)
		vc.view.pin(to: view)
		vc.didMove(toParent: self)
	}
}
extension ExerciseVC: ExerciseTableViewDelegate {
	func heightForRowAt() -> CGFloat {
		75
	}
	func selectedExercise(excerise: ExerciseVM) {
		print(excerise.name)
		let exerciseDetailVC = ExerciseDetailVC(viewModel: excerise)
		exerciseDetailVC.modalTransitionStyle = .coverVertical
		present(exerciseDetailVC, animated: true)
	}
	func selectedCell(section: Int, row: Int) {
		print(section, row)
	}
}

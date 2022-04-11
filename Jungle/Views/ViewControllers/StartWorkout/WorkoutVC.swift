//
//  WorkoutViewController.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/6/22.
//

import UIKit

#warning("I want to move the main view model into the parent instead of the child")
class WorkoutVC: UIViewController{
	var exerciseTableVC: UIViewController?
	let coreDataUtil = CoreDataUtil()
	
	
	// MARK: - UI Elements
	var addExercisesButton: UIButton = {
		var configuration = UIButton.Configuration.tinted()
		configuration.titleAlignment = .center
		var container = AttributeContainer()
		container.font = UIFont.boldSystemFont(ofSize: 14)
		configuration.attributedTitle = AttributedString("Add Exercises", attributes: container)
		
		var button = UIButton(configuration: configuration)
		return button
	}()
	var cancelWorkoutButton: UIButton = {
		var configuration = UIButton.Configuration.tinted()
		configuration.titleAlignment = .center
		configuration.baseBackgroundColor = .systemRed
		configuration.baseForegroundColor = .systemRed
		var container = AttributeContainer()
		container.font = UIFont.boldSystemFont(ofSize: 14)
		configuration.attributedTitle = AttributedString("Cancel Workout", attributes: container)
		
		var button = UIButton(configuration: configuration)
		return button
	}()
	
	var tableVC: WorkoutTableVC = {
		let tableVC = WorkoutTableVC(style: .insetGrouped)
		tableVC.tableView.showsVerticalScrollIndicator = false
		tableVC.view.backgroundColor = .clear
		return tableVC
	}()
	
	// Combines two buttons into view to represent any major actions a user can perform
	// i.e "Add Exercises", and "Cancel Workout"
	func createWorkoutOptionsView() -> UIView{
		let optionsView = UIStackView(frame: CGRect(x: 0, y: 0, width: 200, height: 128))
		optionsView.addArrangedSubview(addExercisesButton)
		optionsView.addArrangedSubview(cancelWorkoutButton)
		
		optionsView.axis = .vertical
		optionsView.distribution = .fillEqually
		optionsView.spacing = 8
		optionsView.isLayoutMarginsRelativeArrangement = true
		//optionsView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)

		return optionsView
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground

		addContainerVC(tableVC)
		navigationBarSetup()
		workoutOptionsSetup()
    }
	/* Primary ViewDidLoad methods */
	func addContainerVC (_ vc: UIViewController) {
		addChild(vc)
		vc.view.pin(to: view)
		vc.didMove(toParent: self)
	}
	func navigationBarSetup() {
		title = "Workout"
		let heartButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAsTemplate))
		let finishButton = UIBarButtonItem(title: "Finish", style: .plain, target: self, action: #selector(finishWorkout))
		navigationItem.rightBarButtonItems = [heartButton, finishButton]
		navigationItem.hidesBackButton = true
	}
	func workoutOptionsSetup(){
		tableVC.tableView.tableFooterView = createWorkoutOptionsView()
		addExercisesButton.addTarget(self, action: #selector(addExercise), for: .touchUpInside)
		cancelWorkoutButton.addTarget(self, action: #selector(cancelWorkout), for: .touchUpInside)
	}
	
	/* Secondary ViewDidLoad methods */
	@objc func addExercise(){
		let navController = UINavigationController(rootViewController:  ExerciseTableVC(withDelegate: self))
		exerciseTableVC = navController
		navController.modalPresentationStyle = .popover
		present(navController, animated: true)
	}
	@objc func cancelWorkout() {
		navigationController?.popViewController(animated: true)
	}
	@objc func finishWorkout() {
		let finishedSets = tableVC.workoutViewModel.workoutExercises.compactMap { (workoutExercise: WorkoutExercise) -> WorkoutExercise? in
			let newSets = workoutExercise.sets.filter { $0.isDone == true }
			if newSets.isEmpty {
				return nil
			}
			let newWorkout = WorkoutExercise(exercise: workoutExercise.exercise, sets: newSets)
			return newWorkout
		}
		coreDataUtil.postWorkout(for: finishedSets)
		navigationController?.popViewController(animated: true)
	}
	@objc func saveAsTemplate() {
		let ac = UIAlertController(title: "Save Workout",message: "Do you want to save this workout as a template for future use?", preferredStyle: .alert)
		let yesAlert = UIAlertAction(title: "Save", style: .default) { action in
			self.helperSave()
		}
		let cancel = UIAlertAction(title: "Cancel", style: .cancel)
		ac.addAction(yesAlert)
		ac.addAction(cancel)
		
		present(ac, animated: true)
	}
	private func helperSave() {
		coreDataUtil.postTemplate(for: tableVC.workoutViewModel.workoutExercises)
	}
}
extension WorkoutVC: ExerciseTableViewDelegate {
	func heightForRowAt() -> CGFloat {
		75
	}
	func selectedExercise(excerise: ExerciseVM) {
		print(excerise.name)
		tableVC.workoutViewModel.addExerciseToWorkout(excerise)
		exerciseTableVC?.dismiss(animated: true)
	}
	func selectedCell(section: Int, row: Int) {
		print(section, row)
	}
}

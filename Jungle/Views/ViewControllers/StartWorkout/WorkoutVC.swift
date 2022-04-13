//
//  WorkoutViewController.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/6/22.
//

import UIKit

fileprivate enum WorkoutVCInfo: String {
	case AlertTitle 			   = "Save Workout"
	case AlertMessage 			   = "Do you want to save this workout as a template for future use?"
	case AlertTextFieldPlaceholder = "Enter a template name"
	case AlertSaveAction 		   = "Save"
	case AlertCancelAction 		   = "Cancel"
	case NavigationTitle 		   = "Workout"
	case NavigationSaveTitle       = "Save as"
	case NavigationFinishTitle     = "Finish"
	case ButtonAddExercises        = "Add Exercises"
	case ButtonCancel              = "Cancel Workout"
	
}

class WorkoutVC: UIViewController{
	var workoutViewModel = WorkoutVM()
	var exerciseTableVC: UIViewController?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		addContainerVC(tableVC)
		navigationBarSetup()
		workoutOptionsSetup()
	}
	
	// MARK: - UI Elements
	var addExercisesButton: SecondaryTintedButton = {
		var button = SecondaryTintedButton(title: WorkoutVCInfo.ButtonAddExercises.rawValue)
		return button
	}()
	var cancelWorkoutButton: SecondaryTintedButton = {
		var button = SecondaryTintedButton(title: WorkoutVCInfo.ButtonCancel.rawValue, color: .systemRed)
		return button
	}()
	
	var tableVC: WorkoutTableVC!
	
	override func loadView() {
		view = UIView()
		view.backgroundColor = .systemBackground
		tableVC = WorkoutTableVC(workoutViewModel: workoutViewModel)
		tableVC.tableView.showsVerticalScrollIndicator = false
		tableVC.view.backgroundColor = .clear
	}
	
	// MARK: - Layout UI
	func createWorkoutOptionsView() -> UIView{
		let optionsView = UIStackView(frame: CGRect(x: 0, y: 0, width: 200, height: 128))
		optionsView.addArrangedSubview(addExercisesButton)
		optionsView.addArrangedSubview(cancelWorkoutButton)
		
		optionsView.axis = .vertical
		optionsView.distribution = .fillEqually
		optionsView.spacing = 8
		optionsView.isLayoutMarginsRelativeArrangement = true
		optionsView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)

		return optionsView
	}
	
	func addContainerVC (_ vc: UIViewController) {
		addChild(vc)
		vc.view.pin(to: view)
		vc.didMove(toParent: self)
	}
	
	// MARK: - Configure UI
	func navigationBarSetup() {
		title = WorkoutVCInfo.NavigationTitle.rawValue
		let heartButton = UIBarButtonItem(title: WorkoutVCInfo.NavigationSaveTitle.rawValue,
										  style: .plain,
										  target: self, action: #selector(saveAsTemplate))
		let finishButton = UIBarButtonItem(title: WorkoutVCInfo.NavigationFinishTitle.rawValue, style: .plain, target: self, action: #selector(finishWorkout))
		navigationItem.rightBarButtonItem = finishButton
		navigationItem.leftBarButtonItem = heartButton
		navigationItem.hidesBackButton = true
	}
	func workoutOptionsSetup(){
		tableVC.tableView.tableFooterView = createWorkoutOptionsView()
		addExercisesButton.addTarget(self, action: #selector(addExercise), for: .touchUpInside)
		cancelWorkoutButton.addTarget(self, action: #selector(cancelWorkout), for: .touchUpInside)
	}
	
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
		workoutViewModel.finishWorkout()
		navigationController?.popViewController(animated: true)
	}
	@objc func saveAsTemplate() {
		let ac = UIAlertController(title: WorkoutVCInfo.AlertTitle.rawValue,message: WorkoutVCInfo.AlertMessage.rawValue, preferredStyle: .alert)
		ac.addTextField {
			$0.placeholder = WorkoutVCInfo.AlertTextFieldPlaceholder.rawValue
		}
		let yesAlert = UIAlertAction(title: WorkoutVCInfo.AlertSaveAction.rawValue, style: .default) { [weak self] action in
			let name = ac.textFields?.first?.text ?? WorkoutVCInfo.NavigationTitle.rawValue
			self?.workoutViewModel.saveAs(name: name)
		}
		let cancel = UIAlertAction(title: WorkoutVCInfo.AlertCancelAction.rawValue, style: .cancel)
		ac.addAction(yesAlert)
		ac.addAction(cancel)
		
		present(ac, animated: true)
	}
	
}

// MARK: - ExerciseTableViewDelegate
extension WorkoutVC: ExerciseTableViewDelegate {
	func heightForRowAt() -> CGFloat {
		75
	}
	func selectedExercise(excerise: ExerciseVM) {
		workoutViewModel.addExerciseToWorkout(excerise)
		exerciseTableVC?.dismiss(animated: true)
	}
	func selectedCell(section: Int, row: Int) {
	}
}

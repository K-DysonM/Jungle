//
//  WorkoutViewController.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/6/22.
//

import UIKit

class WorkoutViewController: UIViewController {

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
	// Combine above into a uiview
	
	
	
	// Going to have to properly create a tableview with sections and rows
	var tableVC: WorkoutTableViewController = {
		let tableVC = WorkoutTableViewController(style: .insetGrouped)
		tableVC.tableView.showsVerticalScrollIndicator = false
		tableVC.view.backgroundColor = .clear
		return tableVC
	}()
	
	override func loadView() {
		view = UIView()
		view.backgroundColor = .systemBackground
	}
	func combineButtons() -> UIView{
		let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 132))
		buttonView.addSubview(addExercisesButton)
		buttonView.addSubview(cancelWorkoutButton)
		
		addExercisesButton.translatesAutoresizingMaskIntoConstraints = false
		cancelWorkoutButton.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			addExercisesButton.topAnchor.constraint(equalTo: buttonView.safeAreaLayoutGuide.topAnchor, constant: 16),
			addExercisesButton.leadingAnchor.constraint(equalTo: buttonView.safeAreaLayoutGuide.leadingAnchor, constant: 0),
			addExercisesButton.trailingAnchor.constraint(equalTo: buttonView.safeAreaLayoutGuide.trailingAnchor, constant: 0),
			addExercisesButton.heightAnchor.constraint(equalToConstant: 50),
			cancelWorkoutButton.topAnchor.constraint(equalTo: addExercisesButton.safeAreaLayoutGuide.bottomAnchor, constant: 16),
			cancelWorkoutButton.leadingAnchor.constraint(equalTo: buttonView.safeAreaLayoutGuide.leadingAnchor, constant: 0),
			cancelWorkoutButton.trailingAnchor.constraint(equalTo: buttonView.safeAreaLayoutGuide.trailingAnchor, constant: 0),
			cancelWorkoutButton.heightAnchor.constraint(equalToConstant: 50),
		])
		return buttonView
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		addSegmentVC(tableVC)
		title = "Workout"
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finish", style: .plain, target: self, action: #selector(finishWorkout))
		navigationItem.hidesBackButton = true
		tableVC.tableView.tableFooterView = combineButtons()
        // Do any additional setup after loading the view.
    }
	@objc func finishWorkout() {
		navigationController?.popViewController(animated: true)
	}
	func addSegmentVC (_ vc: UIViewController) {
		addChild(vc)
		self.view.addSubview(vc.view)
		constrainViewEqual(holderView: self.view, view: vc.view)
		vc.didMove(toParent: self)
	}
	
	func constrainViewEqual(holderView: UIView, view: UIView) {
		view.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			view.topAnchor.constraint(equalTo: holderView.safeAreaLayoutGuide.topAnchor),
			view.leadingAnchor.constraint(equalTo: holderView.safeAreaLayoutGuide.leadingAnchor),
			view.trailingAnchor.constraint(equalTo: holderView.safeAreaLayoutGuide.trailingAnchor),
			view.bottomAnchor.constraint(equalTo: holderView.safeAreaLayoutGuide.bottomAnchor)
		])
	}


}

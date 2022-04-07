//
//  WorkoutViewController.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/6/22.
//

import UIKit

class WorkoutVC: UIViewController {

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
		optionsView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)

		return optionsView
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground

		addSegmentVC(tableVC)
		title = "Workout"
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finish", style: .plain, target: self, action: #selector(finishWorkout))
		navigationItem.hidesBackButton = true
		tableVC.tableView.tableFooterView = createWorkoutOptionsView()
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

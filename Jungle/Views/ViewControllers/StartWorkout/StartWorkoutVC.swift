//
//  StartWorkoutViewController.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/6/22.
//

import UIKit

class StartWorkoutVC: UIViewController {

	var startEmptyWorkoutButton: UIButton = {
		var configuration = UIButton.Configuration.filled()
		configuration.title = "Start an Empty Workout"
		configuration.titleAlignment = .center
		var container = AttributeContainer()
		container.font = UIFont.boldSystemFont(ofSize: 16)
		configuration.attributedTitle = AttributedString("Start an Empty Workout", attributes: container)

		var button = UIButton(configuration: configuration)
		return button
	}()
	
	override func loadView() {
		view = UIView()
		view.backgroundColor = .systemBackground
		view.addSubview(startEmptyWorkoutButton)
		startEmptyWorkoutButton.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			startEmptyWorkoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
			startEmptyWorkoutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
			startEmptyWorkoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
			startEmptyWorkoutButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		title = "Start Workout"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		startEmptyWorkoutButton.addTarget(self, action: #selector(startEmptyWorkout), for: .touchUpInside)
    }
	
	@objc func startEmptyWorkout() {
		let destVC = WorkoutVC()
		navigationController?.pushViewController(destVC, animated: true)
	}

}

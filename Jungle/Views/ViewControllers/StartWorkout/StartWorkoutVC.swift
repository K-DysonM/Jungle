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
		configuration.titleAlignment = .center
		var container = AttributeContainer()
		container.font = UIFont.boldSystemFont(ofSize: 16)
		configuration.attributedTitle = AttributedString("Start an Empty Workout", attributes: container)

		var button = UIButton(configuration: configuration)
		return button
	}()
	
	var gridCollectionView: WorkoutTemplatesCollectionVC = {
		var collectionView = WorkoutTemplatesCollectionVC(collectionViewLayout: UICollectionViewLayout())
		return collectionView
	}()
	
	override func loadView() {
		view = UIView()
		view.backgroundColor = .systemBackground
		
		startEmptyWorkoutButton.pin(to: view, for: [.top,.left,.right], withPadding: 8)
		startEmptyWorkoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		title = "Start Workout"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		startEmptyWorkoutButton.addTarget(self, action: #selector(startEmptyWorkout), for: .touchUpInside)
		addGridCollectionContainer()
    }
	func addGridCollectionContainer () {
		addChild(gridCollectionView)
		gridCollectionView.view.pin(to: view, for: [.left,.right,.bottom], withPadding: 8)
		gridCollectionView.view.topAnchor.constraint(equalTo: startEmptyWorkoutButton.bottomAnchor, constant: 20).isActive = true
		gridCollectionView.didMove(toParent: self)
	}
	@objc func startEmptyWorkout() {
		let destVC = WorkoutVC()
		navigationController?.pushViewController(destVC, animated: true)
	}

}

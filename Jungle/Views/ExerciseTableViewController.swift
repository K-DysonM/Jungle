//
//  ViewController.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/1/22.
//

import UIKit
import Combine

class ExerciseTableViewController: UIViewController {

	var observer: NSKeyValueObservation?
	let exercisesViewModel = ExercisesViewModel()
	var subscriptions = Set<AnyCancellable>()
	
	// MARK: - UI Elements
	var tableView: UITableView = {
		var tableView = UITableView()
		return tableView
	}()
	
	
	override func loadView() {
		view = UIView()
		view.backgroundColor = .systemBackground
		view.addSubview(tableView)
	
		tableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(
			[
				tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
				tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
				tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
				tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			])
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		tableView.dataSource = self
		tableView.delegate = self
		navigationController?.navigationBar.prefersLargeTitles = true
		title = "Exercises"
		tableView.register(ExerciseTableViewCell.self, forCellReuseIdentifier: "Cell")
		exercisesViewModel.$exercisesDict.sink { [weak self] exercisesDict in
			DispatchQueue.main.async {
				self?.tableView.reloadData()
			}
		}.store(in: &subscriptions)
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(toggleSample))
		

	}
	
	@objc func toggleSample() {
		let searchExercisesViewController = SearchExercisesViewController()
		searchExercisesViewController.modalPresentationStyle = .overFullScreen
		present(searchExercisesViewController, animated: false)
		
	}
}
// MARK: - TableView Datasource
extension ExerciseTableViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		exercisesViewModel.exercisesOrder.count
	}
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		exercisesViewModel.exercisesOrder[section]
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		75
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let key = exercisesViewModel.exercisesOrder[section]
		return exercisesViewModel.exercisesDict[key]?.count ?? 0
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ExerciseTableViewCell
		
		let key = exercisesViewModel.exercisesOrder[indexPath.section]
		if let exerciseViewModel = exercisesViewModel.exercisesDict[key]?[indexPath.row] {
			cell.configure(exerciseViewModel)
		}
		return cell
	}
	func sectionIndexTitles(for tableView: UITableView) -> [String]? {
		return exercisesViewModel.exercisesOrder
	}
}
// MARK: - TableView Delegate
extension ExerciseTableViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		print("Selected \(indexPath.row)")
	}
}



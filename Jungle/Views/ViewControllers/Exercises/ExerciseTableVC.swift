//
//  ViewController.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/1/22.
//

import UIKit
import Combine
import CoreData

class ExerciseTableVC: UIViewController {
	
	let exercisesViewModel = ExercisesViewModel()
	var subscriptions = [AnyCancellable]()
	
	// MARK: - UI Elements
	var tableView: UITableView = {
		var tableView = UITableView()
		return tableView
	}()
	
	let searchController: UISearchController = {
		let searchController = UISearchController(searchResultsController: nil)
		searchController.searchBar.placeholder = "Search"
		searchController.searchBar.searchBarStyle = .minimal
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.definesPresentationContext = true
		return searchController
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
		
		
		searchController.searchResultsUpdater = self
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHistory))
	}
	
	@objc func addHistory() {
		let coreDataUtil = CoreDataUtil()
		coreDataUtil.postHistoryRandom()
	}
	
}
// MARK: - TableView Datasource
extension ExerciseTableVC: UITableViewDataSource {
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
extension ExerciseTableVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		print("Selected \(indexPath.row)")
		let key = exercisesViewModel.exercisesOrder[indexPath.section]
		if let exerciseViewModel = exercisesViewModel.exercisesDict[key]?[indexPath.row] {
			let exerciseDetailVC = ExerciseDetailVC(viewModel: exerciseViewModel)
			exerciseDetailVC.modalTransitionStyle = .coverVertical
			present(exerciseDetailVC, animated: true)
		}
	}
}

extension ExerciseTableVC: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		let searchText = searchController.searchBar.text!
		if searchText.isEmpty {
			exercisesViewModel.clearSearch()
		} else {
			exercisesViewModel.searchExercisesFor(searchText)
		}
	}
}


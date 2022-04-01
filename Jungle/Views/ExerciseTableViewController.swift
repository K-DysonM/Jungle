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
	var sample: HeaderSearchView = {
		var sample = HeaderSearchView()
		sample.backgroundColor = .systemBackground
		return sample
	}()
	var tableView: UITableView = {
		var tableView = UITableView()
		return tableView
	}()
	
	
	override func loadView() {
		view = UIView()
		view.backgroundColor = .systemBackground
		
		view.addSubview(tableView)
		view.addSubview(sample)
	
		sample.translatesAutoresizingMaskIntoConstraints = false
		tableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(
			[
				tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
				tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
				tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
				tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
				sample.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
				sample.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
				sample.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
				sample.heightAnchor.constraint(equalToConstant: 75),
				sample.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
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
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(toggleSample))
		
		let temp = HeaderSearchView(frame: CGRect(x: 0, y: 0, width: 1, height: 75))
		tableView.tableHeaderView = temp

		
		self.observer = self.navigationController?.navigationBar.observe(\.bounds, options: [.new], changeHandler: { (navigationBar, changes) in
		
			if let height = changes.newValue?.height {
				print(height)
				if height > 44.0 {
						//Large Title
					self.sample.isHidden = true
				} else {
						//Small Title
					self.sample.isHidden = false
				}
			}
		})
	}
	
	@objc func toggleSample() {
		sample.isHidden.toggle()
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


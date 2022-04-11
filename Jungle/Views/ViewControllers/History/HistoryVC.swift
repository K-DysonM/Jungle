//
//  HistoryVC.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/8/22.
//

import UIKit
import Combine

class HistoryVC: UIViewController {
	let workoutHistoryVM = WorkoutHistoryVM()
	var subscriptions = [AnyCancellable]()
	
	var tableView = UITableView()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setUpTableView()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trash))
        // Do any additional setup after loading the view.
		workoutHistoryVM.$workoutHistory.sink { workoutVMs in
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}.store(in: &subscriptions)
    }
	
	func setUpTableView() {
		view.addSubview(tableView)
		tableView.pin(to: view)
		tableView.register(SubtitleCell.self, forCellReuseIdentifier: "Subtitle")
		tableView.dataSource = self
	}
	
	@objc func refresh() {
		workoutHistoryVM.getWorkoutHistory()
	}
	
	@objc func trash() {
		workoutHistoryVM.clearHistory()
	}

}
// MARK: - UITableViewDataSource
extension HistoryVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		workoutHistoryVM.workoutHistory.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Subtitle", for: indexPath)

		let current = workoutHistoryVM.workoutHistory[indexPath.row]
		cell.textLabel?.text = current.date?.dateAndTimeString()
		cell.detailTextLabel?.text = current.getFirst()
		return cell
	}
}

class SubtitleCell: UITableViewCell {
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

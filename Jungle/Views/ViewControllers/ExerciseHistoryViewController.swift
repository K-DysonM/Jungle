//
//  ExerciseHistoryViewController.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/4/22.
//

import UIKit

class ExerciseHistoryViewController: UIViewController {

	var historyTableView: UITableView = {
		var tableview = UITableView()
		return tableview
	}()
	
	override func loadView() {
		view = UIView()
		view.backgroundColor = .secondarySystemBackground
		view.addSubview(historyTableView)
		historyTableView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			historyTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			historyTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			historyTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			historyTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
		])
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		historyTableView.allowsSelection = false
		historyTableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "Cell")
		historyTableView.backgroundColor = .clear
        // Do any additional setup after loading the view.
    }

}

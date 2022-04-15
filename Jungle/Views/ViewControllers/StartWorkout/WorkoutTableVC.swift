//
//  WorkoutTableViewController.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/6/22.
//

import UIKit
import Combine

fileprivate enum CellNames: String {
	case SectionHeader = "InnerHeader"
	case SectionFooter = "InnerFooter"
	case SectionCell = "Cell"
}

class WorkoutTableVC: UITableViewController {
	var workoutViewModel: WorkoutVM
	var subscriptions = [AnyCancellable]()
	
	init(workoutViewModel: WorkoutVM = WorkoutVM()) {
		self.workoutViewModel = workoutViewModel
		super.init(style: .insetGrouped)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.register(WorkoutTableHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: CellNames.SectionFooter.rawValue)
		tableView.register(WorkoutSetHeaderTableViewCell.self, forCellReuseIdentifier: CellNames.SectionHeader.rawValue)
		tableView.register(WorkoutSetTableViewCell.self, forCellReuseIdentifier: CellNames.SectionCell.rawValue)
		tableView.rowHeight = 50
		
		workoutViewModel.$workoutExercises.sink {_ in
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}.store(in: &subscriptions)
    }
	
	
	@objc func addRowAtSection(_ sender: UITapGestureRecognizer) {
		guard let section  = sender.view?.tag else { return }
		workoutViewModel.addSetForWorkout(section)
	}

    // MARK: - Table view data source
	/*
	 Every section's first row is a 'header' explaining the contents of the row
	 this is why row is always offset by one to compensate for that 'header' row
	 */
    override func numberOfSections(in tableView: UITableView) -> Int {
		return workoutViewModel.workoutExercises.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return workoutViewModel.workoutExercises[section].sets.count + 1
    }
	
	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: CellNames.SectionFooter.rawValue) as! WorkoutTableHeaderFooterView
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addRowAtSection(_:)))
		footer.tag = section
		footer.addGestureRecognizer(tapGestureRecognizer)
		return footer
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return workoutViewModel.getExerciseForSection(section).name
	}
	
	override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		40
	}
	
	/* The first row will be the header and the rest will represent a workout set */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.SectionHeader.rawValue, for: indexPath) as! WorkoutSetHeaderTableViewCell
			return cell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.SectionCell.rawValue, for: indexPath) as! WorkoutSetTableViewCell
			cell.contentView.isUserInteractionEnabled = true
			let currentSetViewModel = workoutViewModel.getSetForExercise(section: indexPath.section, row: indexPath.row-1)
			cell.configure(setViewModel: currentSetViewModel)
			cell.selectionStyle = .none
			return cell
		}
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
	}

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
			if indexPath.row == 0 {
				// Prompt confirmation for entire section
				let exerciseName = workoutViewModel.getExerciseForSection(indexPath.section).name
				let ac = UIAlertController(title: "Remove Exercise?", message: "This removes '\(exerciseName)' and all of its set from your workout", preferredStyle: .alert)
				let delete = UIAlertAction(title: "Remove", style: .destructive) { _ in
					// Remove from viewmodel
					self.workoutViewModel.removeExercise(section: indexPath.section)
				}
				let cancel = UIAlertAction(title: "Cancel", style: .cancel)
				ac.addAction(delete)
				ac.addAction(cancel)
				present(ac, animated: true)
			} else {
				workoutViewModel.removeSetForExercise(section: indexPath.section, row: indexPath.row-1)
			}
		}
    }
}



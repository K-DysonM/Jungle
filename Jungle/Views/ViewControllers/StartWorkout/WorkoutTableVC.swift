//
//  WorkoutTableViewController.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/6/22.
//

import UIKit
import Combine

class WorkoutTableVC: UITableViewController {
	var workoutViewModel = WorkoutViewModel()
	
	enum CellNames: String {
		case SectionHeader = "InnerHeader"
		case SectionFooter = "InnerFooter"
		case SectionCell = "Cell"
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.register(WorkoutTableHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: CellNames.SectionFooter.rawValue)
		tableView.register(WorkoutSetHeaderTableViewCell.self, forCellReuseIdentifier: CellNames.SectionHeader.rawValue)
		tableView.register(WorkoutSetTableViewCell.self, forCellReuseIdentifier: CellNames.SectionCell.rawValue)
    }
	
	@objc func addRowAtSection(_ sender: UITapGestureRecognizer) {
		guard let section  = sender.view?.tag else { return }
		workoutViewModel.addSetForWorkout(section)
		let new_row = workoutViewModel.workouts[section].count
		let indexPath = IndexPath(row: new_row + 1, section: section)
		
		DispatchQueue.main.async {
			self.tableView.insertRows(at: [indexPath], with: .left)
		}
	}

    // MARK: - Table view data source
	/*
	 Every section's first row is a 'header' explaining the contents of the row
	 this is why row is always offset by one to compensate that 'header' row
	 */
    override func numberOfSections(in tableView: UITableView) -> Int {
		return workoutViewModel.workouts.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return workoutViewModel.workouts[section].count + 1
    }
	
	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: CellNames.SectionFooter.rawValue) as! WorkoutTableHeaderFooterView
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addRowAtSection(_:)))
		footer.tag = section
		footer.addGestureRecognizer(tapGestureRecognizer)
		return footer
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Workout Name"
	}
	
	override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		40
	}
	
	/*
	 The first row will be the header and the rest will represent a workout set
	 */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.SectionHeader.rawValue, for: indexPath) as! WorkoutSetHeaderTableViewCell
			return cell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.SectionCell.rawValue, for: indexPath) as! WorkoutSetTableViewCell
			cell.contentView.isUserInteractionEnabled = false
			let currentSetViewModel = workoutViewModel.workouts[indexPath.section][indexPath.row-1]
			cell.configure(setViewModel: currentSetViewModel)
			cell.selectionStyle = .none
			return cell
		}
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
	}

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		indexPath.row == 0 ? false : true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		guard !(indexPath.row == 0) else { return }
        if editingStyle == .delete {
			workoutViewModel.workouts[indexPath.section].remove(at: indexPath.row-1)
			workoutViewModel.updateOrderForWorkout(indexPath.section)
            tableView.deleteRows(at: [indexPath], with: .fade)
		}
    }
}

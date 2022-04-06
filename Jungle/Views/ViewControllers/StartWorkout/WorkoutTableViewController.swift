//
//  WorkoutTableViewController.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/6/22.
//

import UIKit

class WorkoutTableViewController: UITableViewController {

	var rowCount = 4
	
	enum CellNames: String {
		case SectionHeader = "InnerHeader"
		case SectionFooter = "InnerFooter"
		case SectionCell = "Cell"
	}
	var circleLabel: UIButton = {
		let button = UIButton()
		button.backgroundColor = UIColor.green
		button.layer.cornerRadius = 12.5
		button.layer.masksToBounds = true
		button.layer.borderColor = UIColor.gray.cgColor
		button.layer.borderWidth = 3.0
		button.titleLabel?.text = "LL"
		return button
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		tableView.register(WorkoutTableHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: CellNames.SectionFooter.rawValue)
		tableView.register(WorkoutTableViewCell.self, forCellReuseIdentifier: CellNames.SectionHeader.rawValue)
		tableView.register(WorkoutSetTableViewCell.self, forCellReuseIdentifier: CellNames.SectionCell.rawValue)
		tableView.insetsContentViewsToSafeArea = true
		tableView.insetsLayoutMarginsFromSafeArea = true
    }
	@objc func addRow() {
		rowCount += 1
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
	
	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: CellNames.SectionFooter.rawValue) as! WorkoutTableHeaderFooterView
		footer.addSetButton.addTarget(self, action: #selector(addRow), for: .touchUpInside)
		return footer
	}
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Workout Name"
	}
	
	override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		30
	}
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.SectionHeader.rawValue, for: indexPath) as! WorkoutTableViewCell
			return cell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.SectionCell.rawValue, for: indexPath) as! WorkoutSetTableViewCell
			cell.contentView.isUserInteractionEnabled = false
			cell.configure()
			cell.selectionStyle = .none
			return cell
		}
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
	}
	
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		if indexPath.row == 0 {
			return false
		} else {
			return true
		}
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		guard !(indexPath.row == 0) else { return }
        if editingStyle == .delete {
			rowCount -= 1
			tableView.reloadData()
            //tableView.deleteRows(at: [indexPath], with: .fade)
		} else if editingStyle == .insert {
             
        }    
    }

}

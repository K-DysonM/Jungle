//
//  WorkoutTableViewCell.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/6/22.
//

import UIKit
import Combine

class WorkoutSetHeaderTableViewCell: UITableViewCell {
	
	// MARK: - UIView elements
	var setLabel: UILabel = {
		var label = HeaderLabel()
		label.text = WorkoutDetail.Set.rawValue
		return label
	}()
	
	var previousLabel: UILabel = {
		var label = HeaderLabel()
		label.text = WorkoutDetail.Previous.rawValue
		return label
	}()
	
	var poundsLabel: UILabel = {
		var label = HeaderLabel()
		label.text = WorkoutDetail.Pounds.rawValue
		return label
	}()
	
	var repsLabel: UILabel = {
		var label = HeaderLabel()
		label.text = WorkoutDetail.Reps.rawValue
		return label
	}()
	
	var checkLabel: UILabel = {
		var label = HeaderLabel()
		label.text = WorkoutDetail.Done.rawValue
		return label
	}()
	
	var leftStackView: UIStackView = {
		var stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.distribution = .fill
		return stackView
	}()
	
	var rightStackView: UIStackView = {
		var stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		return stackView
	}()
	
	var mainStackView: UIStackView = {
		var stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		return stackView
	}()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		layoutUI()
	}
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		layoutUI()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		layoutUI()
	}
	// MARK: - Layout UI
	
	func layoutUI() {
		mainStackView.addArrangedSubview(leftStackView)
		mainStackView.addArrangedSubview(rightStackView)
		
		leftStackView.addArrangedSubview(setLabel)
		leftStackView.addArrangedSubview(previousLabel)
		
		rightStackView.addArrangedSubview(poundsLabel)
		rightStackView.addArrangedSubview(repsLabel)
		rightStackView.addArrangedSubview(checkLabel)
		
		self.addSubview(mainStackView)
		mainStackView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate(
			[
				mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
				mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
				mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
				mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
				previousLabel.widthAnchor.constraint(equalTo: leftStackView.widthAnchor, multiplier: 0.75)
			])
	}
}

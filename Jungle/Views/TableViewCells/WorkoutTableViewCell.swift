//
//  WorkoutTableViewCell.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/6/22.
//

import UIKit
import Combine

class WorkoutTableViewCell: UITableViewCell {

	var subscriptions =  Set<AnyCancellable>()
	
	// MARK: - UIView elements
	
	var setLabel: UILabel = {
		var label = UILabel()
		label.text = "Set"
		label.font = UIFont.systemFont(ofSize: 16.00, weight: .bold)
		label.textAlignment = .center
		return label
	}()
	
	var previousLabel: UILabel = {
		var label = UILabel()
		label.text = "Previous"
		label.font = UIFont.systemFont(ofSize: 16.00, weight: .bold)
		label.textAlignment = .center
		return label
	}()
	
	var poundsLabel: UILabel = {
		var label = UILabel()
		label.text = "lbs"
		label.font = UIFont.systemFont(ofSize: 16.00, weight: .bold)
		label.textAlignment = .center
		return label
	}()
	
	var repsLabel: UILabel = {
		var label = UILabel()
		label.text = "Reps"
		label.font = UIFont.systemFont(ofSize: 16.00, weight: .bold)
		label.textAlignment = .center
		return label
	}()
	
	var checkLabel: UILabel = {
		var label = UILabel()
		label.text = "✅"
		label.font = UIFont.systemFont(ofSize: 16.00, weight: .bold)
		label.textAlignment = .center
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
		print(#function)
			// Initialization code
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
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
			// Configure the view for the selected state
	}
	
		// MARK: - Layout UI
	
	func layoutUI() {
		print(#function)
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
	// MARK: - Configure UI
	
	func configure() {
		// #warning unimplemented
	}
}

//
//  WorkoutSetTableViewCell.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/6/22.
//

import UIKit
import Combine

class WorkoutSetTableViewCell: UITableViewCell {

	var subscriptions =  Set<AnyCancellable>()
	
	// MARK: - UIView elements
	
	var setLabel: UILabel = {
		var label = UILabel()
		label.text = "1"
		label.backgroundColor = .secondarySystemGroupedBackground
		label.font = UIFont.systemFont(ofSize: 16.00, weight: .bold)
		label.textAlignment = .center
		return label
	}()
	
	var previousLabel: UILabel = {
		var label = UILabel()
		label.text = "85lb x 10"
		label.backgroundColor = .secondarySystemGroupedBackground
		label.font = UIFont.systemFont(ofSize: 16.00, weight: .bold)
		label.textAlignment = .center
		return label
	}()
	
	var poundsTextField: UITextField = {
		var textField = UITextField()
		textField.placeholder = "10"
		textField.textAlignment = .center
		textField.keyboardType = .numberPad
		textField.backgroundColor = .secondarySystemGroupedBackground
		textField.font = UIFont.systemFont(ofSize: 16.00, weight: .bold)
		textField.addDoneCancelToolbar()
		return textField
	}()
	
	var repsTextField: UITextField = {
		var textField = UITextField()
		textField.placeholder = "12"
		textField.textAlignment = .center
		textField.keyboardType = .numberPad
		textField.backgroundColor = .secondarySystemGroupedBackground
		textField.font = UIFont.systemFont(ofSize: 16.00, weight: .bold)
		textField.addDoneCancelToolbar()
		return textField
	}()
	
	var circleView: CircleView = {
		let view = CircleView()
		return view
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
	
	@objc func tester() {
		circleView.toggle()
	}
	
	func layoutUI() {
		print(#function)
		//circleView.backgroundColor = .clear
		circleView.circleLabel.addTarget(self, action: #selector(tester), for: .touchUpInside)
		
		mainStackView.addArrangedSubview(leftStackView)
		mainStackView.addArrangedSubview(rightStackView)
		
		leftStackView.addArrangedSubview(setLabel)
		leftStackView.addArrangedSubview(previousLabel)
		
		rightStackView.addArrangedSubview(poundsTextField)
		rightStackView.addArrangedSubview(repsTextField)
		rightStackView.addArrangedSubview(circleView)
		
		
		self.addSubview(mainStackView)
		mainStackView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate(
			[
				mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
				mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
				mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
				mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
				previousLabel.widthAnchor.constraint(equalTo: leftStackView.widthAnchor, multiplier: 0.75),
			])
		
	}
	// MARK: - Configure UI
	
	func configure() {
		// #warning unimplemented
	}

}

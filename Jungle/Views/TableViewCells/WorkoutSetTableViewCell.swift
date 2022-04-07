//
//  WorkoutSetTableViewCell.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/6/22.
//

import UIKit
import Combine

class WorkoutSetTableViewCell: UITableViewCell {
	var setViewModel: SetViewModel?
	var subscriptions =  [AnyCancellable]()
	
	// MARK: - UI elements
	
	var setLabel: UILabel = {
		var label = UILabel()
		label.text = "1"
		label.backgroundColor = .clear
		label.font = UIFont.systemFont(ofSize: 16.00, weight: .bold)
		label.textAlignment = .center
		return label
	}()
	
	var previousLabel: UILabel = {
		var label = UILabel()
		label.text = "85lb x 10"
		label.backgroundColor = .clear
		label.font = UIFont.systemFont(ofSize: 16.00, weight: .bold)
		label.textAlignment = .center
		return label
	}()
	
	var poundsTextField: UITextField = {
		var textField = UITextField()
		textField.placeholder = "10"
		textField.textAlignment = .center
		textField.keyboardType = .numberPad
		textField.backgroundColor = .clear
		textField.font = UIFont.systemFont(ofSize: 16.00, weight: .bold)
		textField.addDoneCancelToolbar()
		return textField
	}()
	
	var repsTextField: UITextField = {
		var textField = UITextField()
		textField.placeholder = "12"
		textField.textAlignment = .center
		textField.keyboardType = .numberPad
		textField.backgroundColor = .clear
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
	@objc func tester() {
		let generator = UIImpactFeedbackGenerator(style: .light)
		generator.impactOccurred()
		setViewModel?.toggle()
	}
	
	func layoutUI() {
		//circleView.backgroundColor = .clear
		circleView.circleLabel.removeTarget(nil, action: nil, for: .allEvents)
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
	//GOOD TALKING POINT ISSUE WITH SUBSCRIPTIONS
	func configure(setViewModel: SetViewModel) {
		subscriptions.removeAll()
		self.setViewModel = setViewModel
		setViewModel.$numberOrder.sink { order in
			self.setLabel.text = String(order)
		}.store(in: &subscriptions)
		
		setViewModel.$isDone.sink { isDone in
			if isDone {
				self.backgroundColor = .green.withAlphaComponent(0.3)
				self.circleView.turnOn()
			} else {
				self.backgroundColor = .systemBackground
				self.circleView.turnOff()
			}
		}.store(in: &subscriptions)
	}

}

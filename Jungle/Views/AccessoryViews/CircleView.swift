//
//  CircleView.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/6/22.
//

import UIKit

class CircleView: UIView {

	private(set) var isOn: Bool = false
	
	var circleLabel: UIButton = {
		let button = UIButton()
		button.backgroundColor = UIColor.white
		button.layer.cornerRadius = 10.00
		button.layer.masksToBounds = true
		button.layer.borderColor = UIColor.gray.cgColor
		button.layer.borderWidth = 1.5
		button.titleLabel?.text = "LL"
		return button
	}()
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		layoutUI()
	}
	override init(frame: CGRect) {
		super.init(frame: frame)
		layoutUI()
	}
    
	// MARK: - Layout UI
	func layoutUI() {
		print(#function)
		self.addSubview(circleLabel)
		circleLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(
			[
				circleLabel.heightAnchor.constraint(equalToConstant: 20),
				circleLabel.widthAnchor.constraint(equalTo: circleLabel.heightAnchor),
				circleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
				circleLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
			])

	}
	
	func toggle() {
		isOn.toggle()
		circleLabel.backgroundColor = isOn == true ? .green : .systemBackground
	}

}

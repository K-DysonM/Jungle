//
//  WorkoutTableHeaderFooterView.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/6/22.
//

import UIKit

class WorkoutTableHeaderFooterView: UITableViewHeaderFooterView {
	
	var addSetButton: UIButton = {
		var configuration = UIButton.Configuration.gray()
		configuration.titleAlignment = .center
		var container = AttributeContainer()
		container.font = UIFont.boldSystemFont(ofSize: 14)
		configuration.attributedTitle = AttributedString("Add Set", attributes: container)
		
		var button = UIButton(configuration: configuration)
		return button
	}()
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		layoutUI()
	}
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		layoutUI()
	}
	
	func layoutUI() {
		print(#function)
		
		self.addSubview(addSetButton)
		addSetButton.translatesAutoresizingMaskIntoConstraints = false
		
		
		NSLayoutConstraint.activate([
			addSetButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
			addSetButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
			addSetButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
			addSetButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
		])
	}

}

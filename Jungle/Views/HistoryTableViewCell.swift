//
//  HistoryTableViewCell.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/3/22.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

	// MARK: - UI Elements
	var title: UILabel = {
		var label = UILabel()
		label.text = "Workout Name"
		label.font = UIFont.systemFont(ofSize: 16.00, weight: .bold)
		label.textAlignment = .left
		return label
	}()
	
	var subtitle: UILabel = {
		var label = UILabel()
		label.text = "4:09, Thursday, Apr 3rd 2022"
		label.font = UIFont.systemFont(ofSize: 16.00, weight: .regular)
		label.textAlignment = .left
		return label
	}()
	
	var setTitle: UILabel = {
		var label = UILabel()
		label.text = "Best Set Peformed"
		label.font = UIFont.systemFont(ofSize: 16.00, weight: .bold)
		label.textAlignment = .left
		return label
	}()
	
	var setSubtitle: UILabel = {
		var label = UILabel()
		label.text = "40 lb x 12"
		label.font = UIFont.systemFont(ofSize: 16.00, weight: .regular)
		label.textAlignment = .left
		return label
	}()
	
	var stackView: UIStackView = {
		var stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 8
		stackView.distribution = .fillEqually
		return stackView
	}()
	
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
		print(#function)
		[title, subtitle, setTitle, setSubtitle].forEach {
			stackView.addArrangedSubview($0)
		}
		
		self.addSubview(stackView)
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate(
			[
				stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
				stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
				stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
				stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8)
			])
		
	}
	
	
	// MARK: - Configure UI
	func configure(viewModel: HistoryViewModel) {
		subtitle.text = viewModel.time
		setSubtitle.text = viewModel.bestSet
	}

}

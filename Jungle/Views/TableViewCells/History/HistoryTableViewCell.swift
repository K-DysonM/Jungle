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
	
	var background: UIView = {
		var view = UIView()
		view.backgroundColor = .clear
		return view
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
		[title, subtitle, setTitle, setSubtitle].forEach {
			stackView.addArrangedSubview($0)
		}
		backgroundColor = .clear
		contentView.addSubview(background)
		contentView.addSubview(stackView)
		stackView.backgroundColor = .systemBackground
		background.backgroundColor = .systemBackground
		background.layer.cornerRadius = 10.0
		background.translatesAutoresizingMaskIntoConstraints = false
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate(
			[
				background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
				background.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
				background.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
				background.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
				stackView.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 8),
				stackView.topAnchor.constraint(equalTo: background.safeAreaLayoutGuide.topAnchor, constant: 8),
				stackView.trailingAnchor.constraint(equalTo: background.safeAreaLayoutGuide.trailingAnchor, constant: -8),
				stackView.bottomAnchor.constraint(equalTo: background.safeAreaLayoutGuide.bottomAnchor, constant: -8)
			])
		
	}
	
	// MARK: - Configure UI
	func configure(viewModel: SetVM) {
		subtitle.text = viewModel.date?.dateString("EEEE, MMMM dd YYYY") ?? ""
		setSubtitle.text = "\(viewModel.weight) lb x \(viewModel.reps)"
	}

}

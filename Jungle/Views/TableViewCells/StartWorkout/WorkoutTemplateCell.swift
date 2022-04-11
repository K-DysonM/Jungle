//
//  WorkoutTemplateCell.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/10/22.
//

import UIKit

class WorkoutTemplateCell: UICollectionViewCell {
	
	// MARK: - UI elements
	var titleLabel: UILabel = {
		var label = UILabel()
		label.numberOfLines = 1
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
		return label
	}()
	
	var subtitleLabel: UILabel = {
		var label = UILabel()
		label.numberOfLines = 0
		label.lineBreakMode = .byTruncatingTail
		label.textAlignment = .left
		label.textColor = .secondaryLabel
		label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
		return label
	}()
	
	private var mainStackView: UIStackView = {
		var stackView = UIStackView()
		stackView.axis = .vertical
		//stackView.alignment = .center
		stackView.spacing = 8
		stackView.distribution = .fillProportionally
		return stackView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		layoutUI()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		layoutUI()
	}
	
	private func layoutUI() {
		[titleLabel, subtitleLabel].forEach {
			mainStackView.addArrangedSubview($0)
		}
		mainStackView.pin(to: self.contentView, withPadding: 14)
		layer.borderColor = UIColor.systemGray5.cgColor
		layer.borderWidth = 1.0
		layer.cornerRadius = 15
	}
	
	#warning("Missing implementation")
	func configure() {
		
	}
}

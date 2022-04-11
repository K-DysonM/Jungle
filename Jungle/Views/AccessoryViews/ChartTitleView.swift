//
//  ChartTitleView.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/4/22.
//

import UIKit

class ChartTitleView: UIView {
	
	// MARK: - UI Elements
	var title: UILabel = {
		var label = UILabel()
		label.text = "Best Set"
		label.font = UIFont.systemFont(ofSize: 12.00, weight: .semibold)
		label.textColor = .systemGray3
		label.textAlignment = .center
		return label
	}()
	
	var lineView: UIView = {
		var lineView = UIView()
		lineView.layer.borderWidth = 1.0
		lineView.layer.borderColor = UIColor.systemGray2.cgColor
		return lineView
	}()
	
	var stackView: UIStackView = {
		var stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 5
		stackView.distribution = .fill
		stackView.alignment = .center
		return stackView
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
		[title, lineView].forEach {
			stackView.addArrangedSubview($0)
		}
		backgroundColor = .clear
		stackView.backgroundColor = .systemBackground
		
		stackView.pin(to: self, withPadding: 8)
		
	}
	
	
}

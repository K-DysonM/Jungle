//
//  WorkoutTemplateHeaderView.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/10/22.
//

import UIKit

class WorkoutTemplateHeaderView: UICollectionReusableView {

	var headerTitleLabel = HeaderLabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		layoutUI()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		layoutUI()
	}
	
	func layoutUI() {
		headerTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
		headerTitleLabel.pin(to: self, withPadding: 8)
	}
}

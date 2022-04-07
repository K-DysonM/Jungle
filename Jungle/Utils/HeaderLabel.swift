//
//  HeaderLabel.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/7/22.
//

import Foundation
import UIKit

class HeaderLabel: UILabel {
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
		commonInit()
	}
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	func commonInit(){
		font = UIFont.systemFont(ofSize: 16.00, weight: .bold)
		textAlignment = .center
		textColor = .label
	}
}

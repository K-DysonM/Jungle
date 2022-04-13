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

class SecondaryTintedButton: UIButton {
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	init(title: String, color: UIColor = .systemBlue) {
		super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		commonInit(title: title, color: color)
	}
	func commonInit(title: String = "Button", color: UIColor = .systemBlue){
		var configuration = UIButton.Configuration.tinted()
		configuration.titleAlignment = .center
		var container = AttributeContainer()
		configuration.baseBackgroundColor = color
		configuration.baseForegroundColor = color
		container.font = UIFont.boldSystemFont(ofSize: 14)
		configuration.attributedTitle = AttributedString(title, attributes: container)
		
		self.configuration = configuration
	}
}

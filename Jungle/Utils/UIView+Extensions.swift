//
//  UIView+Extensions.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/7/22.
//

import Foundation
import UIKit

extension UIView {
	func pin(to view: UIView) {
		view.addSubview(self)
		self.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate(
			[
				self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
				self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
				self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
				self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			])
	}
	func pin(to view: UIView, for sides: [Side] = [.top,.bottom,.left,.right], withPadding padding: CGFloat = 0 ) {
		view.addSubview(self)
		self.translatesAutoresizingMaskIntoConstraints = false
		
		sides.forEach { side in
			switch side {
			case .top:
				self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding).isActive = true
			case .bottom:
				self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: padding * -1).isActive = true
			case .left:
				self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding).isActive = true
			case .right:
				self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: padding * -1).isActive = true
			}
		}
	}
	
	enum Side {
		case top
		case right
		case bottom
		case left
	}
}

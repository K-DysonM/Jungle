//
//  HeaderSearchView.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/1/22.
//

import UIKit

class HeaderSearchView: UIView {

	var searchBar: UISearchBar = {
		var searchBar = UISearchBar()
		searchBar.placeholder = "Search"
		searchBar.showsCancelButton = true
		searchBar.autocorrectionType = .no
		return searchBar
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		layoutUI()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		layoutUI()
	}
	
	// MARK: - Layout UI
	
	func layoutUI(){
		addSubview(searchBar)
		searchBar.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
			searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
			searchBar.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
			
		])
	}

}

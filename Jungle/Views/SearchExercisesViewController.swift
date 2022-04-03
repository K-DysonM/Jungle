//
//  SearchExercisesViewController.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/2/22.
//

import UIKit

class SearchExercisesViewController: UIViewController {

	var searchBarTopConstraint: NSLayoutConstraint?
	
	// MARK: - UI Elements
	var searchView: HeaderSearchView = {
		var sample = HeaderSearchView()
		sample.searchBar.backgroundColor = .secondarySystemBackground
		sample.searchBar.barTintColor = .secondarySystemBackground
		//sample.searchBar.tintColor = .red
		UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.systemBlue], for: .normal)
		return sample
	}()
	
	var backgroundView: UIView = {
		var background = UIView()
		return background
	}()
	override func loadView() {
		view = UIView()
		view.backgroundColor = .clear
		view.addSubview(backgroundView)
		view.addSubview(searchView)
		searchView.translatesAutoresizingMaskIntoConstraints = false
		backgroundView.translatesAutoresizingMaskIntoConstraints = false
		
		
		NSLayoutConstraint.activate(
			[
				backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
				backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
				backgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
				backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
				searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
				searchView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
				searchView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
			])
		
		searchBarTopConstraint = searchView.heightAnchor.constraint(equalToConstant: 0)
		searchBarTopConstraint?.isActive = true
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		searchView.searchBar.delegate = self
		
    }
	
	override func viewDidAppear(_ animated: Bool) {
		self.searchBarTopConstraint?.constant = 75
		UIView.animate(withDuration: 0.20, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.20, options: .curveEaseIn) {
			self.view.layoutIfNeeded()
		}
		searchView.searchBar.becomeFirstResponder()
	}
    

}
extension SearchExercisesViewController: UISearchBarDelegate {
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		self.dismiss(animated: false)
	}
}

//
//  WorkoutTemplatesCollectionVC.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/10/22.
//

import UIKit
import Combine

private let reuseIdentifier = "Cell"

class WorkoutTemplatesCollectionVC: UICollectionViewController {

	var templateVM = TemplateVM()
	var subscriptions = [AnyCancellable]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setUpCollectionView()
    }
	
	func setUpCollectionView() {
		collectionView.register(WorkoutTemplateCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		collectionView.register(WorkoutTemplateHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: "Header")
		
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		
		layout.minimumInteritemSpacing = 8
		layout.minimumLineSpacing = 16
		
		collectionView.setCollectionViewLayout(layout, animated: true)
		
		templateVM.$templates.sink {_ in
			DispatchQueue.main.async {
				self.collectionView.reloadData()
			}
		}.store(in: &subscriptions)
	}

    // MARK: UICollectionViewDataSource
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		1
	}
	
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
		return templateVM.templates.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WorkoutTemplateCell
		let currentTemplate = templateVM.templates[indexPath.row]
		cell.titleLabel.text = "Push Workout"
		cell.subtitleLabel.text = currentTemplate.string()
        // Configure the cell
    
        return cell
    }
	
	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		switch kind {
		case UICollectionView.elementKindSectionHeader:
			let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! WorkoutTemplateHeaderView

			print("got correct one")
			headerView.headerTitleLabel.textAlignment = .left
			headerView.headerTitleLabel.text = "Example Templates"
			return headerView
		default:
			print("Invalid element")
			assert(false)
		}
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let currentTemplate = templateVM.templates[indexPath.row]
		let start_workout = WorkoutVC()
		start_workout.tableVC.workoutViewModel = currentTemplate
		navigationController?.pushViewController(start_workout, animated: true)
	}

}
// MARK: - UICollectionViewDelegateFlowLayout
extension WorkoutTemplatesCollectionVC: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView,
								 layout collectionViewLayout: UICollectionViewLayout,
								 insetForSectionAt section: Int) -> UIEdgeInsets {

		return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
	}
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		let lay = collectionViewLayout as! UICollectionViewFlowLayout
		let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
		lay.headerReferenceSize = CGSize(width: widthPerItem, height: 50)
		return CGSize(width: widthPerItem - 8, height: 150)
	}
}

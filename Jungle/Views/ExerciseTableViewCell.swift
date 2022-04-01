//
//  ExerciseTableViewCell.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/1/22.
//

import UIKit
import Combine

class ExerciseTableViewCell: UITableViewCell {

	var subscriptions =  Set<AnyCancellable>()
	
	// MARK: - UIView elements
	var image: UIImageView = {
		var image = UIImageView()
		image.contentMode = .scaleAspectFit
		return image
	}()
	
	var title: UILabel = {
		var label = UILabel()
		label.text = "Workout Name"
		label.font = UIFont.systemFont(ofSize: 16.00, weight: .bold)
		label.textAlignment = .left
		return label
	}()
	
	var subtitle: UILabel = {
		var label = UILabel()
		label.text = "Targeted body part"
		label.font = UIFont.systemFont(ofSize: 16.00, weight: .regular)
		label.textAlignment = .left
		return label
	}()
	
	var detail: UILabel = {
		var label = UILabel()
		label.text = "Last set"
		label.font = UIFont.systemFont(ofSize: 16.00, weight: .regular)
		label.textAlignment = .right
		return label
	}()
	
	var infoStackView: UIStackView = {
		var stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		return stackView
	}()
	
	var stackView: UIStackView = {
		var stackView = UIStackView()
		stackView.axis = .vertical
		stackView.distribution = .fillEqually
		return stackView
	}()
	
    override func awakeFromNib() {
        super.awakeFromNib()
		print(#function)
        // Initialization code
		layoutUI()
    }
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		layoutUI()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		layoutUI()
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	// MARK: - Layout UI
	
	func layoutUI() {
		print(#function)
		infoStackView.addArrangedSubview(subtitle)
		infoStackView.addArrangedSubview(detail)
		
		stackView.addArrangedSubview(title)
		stackView.addArrangedSubview(infoStackView)
		
		self.addSubview(stackView)
		self.addSubview(image)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		image.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate(
			[
				image.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8),
				image.widthAnchor.constraint(equalTo: image.heightAnchor),
				image.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
				image.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
				stackView.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
				stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
				stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
				stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8)
			])
		
	}
	// MARK: - Configure UI
	
	func configure(_ exerciseViewModel: ExerciseViewModel) {
		exerciseViewModel.$name.assign(to: \.text!, on: title).store(in: &subscriptions)
		exerciseViewModel.$bodyPart.assign(to: \.text!, on: subtitle).store(in: &subscriptions)
		exerciseViewModel.$lastSet.assign(to: \.text!, on: detail).store(in: &subscriptions)
		image.image = UIImage(named: exerciseViewModel.image)
	}

}

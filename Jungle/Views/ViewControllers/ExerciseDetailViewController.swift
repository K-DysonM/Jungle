//
//  ExerciseDetailViewController.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/3/22.
//

import UIKit
import Charts

class ExerciseDetailViewController: UIViewController {
	var exerciseViewModel: ExerciseViewModel
	
	init(viewModel: ExerciseViewModel) {
		exerciseViewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - UI Elements
	var titleLabel: UILabel = {
		var label = UILabel()
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
		return label
	}()
	var segmentControl: UISegmentedControl = {
		var segmentControl = UISegmentedControl(items: ["History","Charts"])
		return segmentControl
	}()
	var historyVC: ExerciseHistoryViewController = {
		let historyVC = ExerciseHistoryViewController()
		historyVC.view.backgroundColor = .clear
		return historyVC
	}()
	
	var chartVC: ExerciseChartViewController = {
		let chartVC = ExerciseChartViewController()
		chartVC.view.backgroundColor = .clear
		return chartVC
	}()
	
	override func loadView() {
		view = UIView()
		view.backgroundColor = .secondarySystemBackground
		[titleLabel, segmentControl].forEach {
			view.addSubview($0)
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
			titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
			titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  -8),
			segmentControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			segmentControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
			segmentControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
		])
		
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		segmentControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
		segmentControl.selectedSegmentIndex = 0
	
		chartVC.view.isHidden = true
		titleLabel.text = exerciseViewModel.name
		
		setData()
		addSegmentVC(historyVC)
		addSegmentVC(chartVC)
		chartVC.lineChartView.delegate = self
		
		
		
		
		historyVC.historyTableView.dataSource = self
    }
	func addSegmentVC (_ vc: UIViewController) {
		addChild(vc)
		self.view.addSubview(vc.view)
		constrainViewEqual(holderView: self.view, view: vc.view)
		vc.didMove(toParent: self)
	}
	func constrainViewEqual(holderView: UIView, view: UIView) {
		view.translatesAutoresizingMaskIntoConstraints = false

		let pinTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
										toItem: segmentControl, attribute: .bottom, multiplier: 1.0, constant: 0)
		let pinBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
										   toItem: holderView, attribute: .bottom, multiplier: 1.0, constant: 0)
		let pinLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal,
										 toItem: holderView, attribute: .left, multiplier: 1.0, constant: 8)
		let pinRight = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal,
										  toItem: holderView, attribute: .right, multiplier: 1.0, constant: -8)
		
		holderView.addConstraints([pinTop, pinBottom, pinLeft, pinRight])
	}

	@objc func segmentValueChanged(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
			case 0:
				historyVC.view.isHidden = false
				chartVC.view.isHidden = true
			case 1:
				chartVC.view.isHidden = false
				historyVC.view.isHidden = true
			default:
				print("not implemented")
		}
	}
	
	func setData() {
		chartVC.lineChartView.xAxis.valueFormatter = self
		let set1 = LineChartDataSet(entries: exerciseViewModel.getChartData())
		set1.mode = .linear
		set1.colors = [UIColor.systemGreen]
		set1.circleColors = [UIColor.systemGreen]
		set1.circleRadius = 4.0
		set1.circleHoleRadius = 2.0
		
		//Setting area under line
		let gradientColors = [UIColor.systemGreen.cgColor, UIColor.systemGreen.withAlphaComponent(0.2).cgColor] as CFArray // Colors of the gradient
		let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
		let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
		set1.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient
		set1.drawFilledEnabled = true // Draw the Gradient
		
		let data = LineChartData(dataSet: set1)
		data.setDrawValues(false)
		chartVC.lineChartView.data = data
		chartVC.lineChartView.legend.enabled = false
		
		chartVC.lineChartView.data?.highlightEnabled = true
		chartVC.lineChartView.fitScreen()
		chartVC.lineChartView.notifyDataSetChanged()
	}
}

// MARK: - TableView Datasource
extension ExerciseDetailViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		150
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		exerciseViewModel.history.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HistoryTableViewCell
		let historyViewModel = exerciseViewModel.history[indexPath.row]
		cell.configure(viewModel: historyViewModel)
		return cell
	}
}

// MARK: - ChartView Delegate
extension ExerciseDetailViewController: ChartViewDelegate {
	func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
		print(entry)
	}
}
// MARK: - AxisValueFormatter
extension ExerciseDetailViewController: IAxisValueFormatter {
	func stringForValue(_ value: Double, axis: AxisBase?) -> String {
		let date = Date(timeIntervalSince1970: value)
		let formatter3 = DateFormatter()
		formatter3.dateFormat = "MMM d"
		return formatter3.string(from: date)
	}
}


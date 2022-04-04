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
	
	var historyTableView: UITableView = {
		var tableview = UITableView()
		return tableview
	}()
	
	var lineChartView: LineChartView = {
		var linechart = LineChartView()
		linechart.backgroundColor = .systemBackground
		linechart.leftAxis.enabled = false
		linechart.rightAxis.setLabelCount(2, force: true)
		linechart.rightAxis.axisLineColor = .systemBackground
		
		linechart.xAxis.labelPosition = .bottom
		linechart.xAxis.axisLineColor = .systemBackground
		linechart.xAxis.drawGridLinesEnabled = false
		
		linechart.rightAxis.axisMinimum = 0
		linechart.leftAxis.axisMinimum = 0
		
		linechart.pinchZoomEnabled = false
		linechart.scaleXEnabled = false
		linechart.scaleYEnabled = false
		return linechart
	}()
	
	override func loadView() {
		view = UIView()
		view.backgroundColor = .systemBackground
		[titleLabel, segmentControl, historyTableView, lineChartView].forEach {
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
		
		NSLayoutConstraint.activate([
			historyTableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor,constant: 16),
			historyTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
			historyTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
			historyTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
			lineChartView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor,constant: 16),
			lineChartView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
			lineChartView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
			lineChartView.heightAnchor.constraint(equalToConstant: 300)
		])
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		segmentControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
		segmentControl.selectedSegmentIndex = 0
		historyTableView.isHidden = false
		lineChartView.isHidden = true
		
		titleLabel.text = exerciseViewModel.name
		historyTableView.dataSource = self
		historyTableView.allowsSelection = false
		historyTableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "Cell")
		
		setData()
    }

	@objc func segmentValueChanged(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
			case 0:
				historyTableView.isHidden = false
				lineChartView.isHidden = true
			case 1:
				lineChartView.isHidden = false
				historyTableView.isHidden = true
			default:
				print("not implemented")
		}
	}
	
	func setData() {
		lineChartView.xAxis.valueFormatter = self
		let set1 = LineChartDataSet(entries: exerciseViewModel.getChartData() , label: "Progress")
		set1.colors = [UIColor.systemBlue]
		set1.circleColors = [UIColor.systemBlue]
		set1.circleRadius = 4.0
		set1.circleHoleRadius = 2.0
		let data = LineChartData(dataSet: set1)
		lineChartView.data = data
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
extension ExerciseDetailViewController: IAxisValueFormatter {
	func stringForValue(_ value: Double, axis: AxisBase?) -> String {
		let date = Date(timeIntervalSince1970: value)
		let formatter3 = DateFormatter()
		formatter3.dateFormat = "MMM d"
		return formatter3.string(from: date)
	}
}

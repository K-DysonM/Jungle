//
//  ExerciseChartViewController.swift
//  Jungle
//
//  Created by Kiana Dyson on 4/4/22.
//

import UIKit
import Charts

class ExerciseChartViewController: UIViewController {

	var lineChartTitle: ChartTitleView = {
		var title = ChartTitleView()
		return title
	}()
	
	var lineChartView: LineChartView = {
		var linechart = LineChartView()
		linechart.backgroundColor = .clear
		
		linechart.rightAxis.enabled = false
		linechart.leftAxis.drawGridLinesEnabled = false
		linechart.rightAxis.drawGridLinesEnabled = false
		linechart.leftAxis.labelFont = UIFont.systemFont(ofSize: 10, weight: .semibold)
		linechart.drawGridBackgroundEnabled = false
		
		linechart.xAxis.labelPosition = .bottom
		linechart.xAxis.labelFont = UIFont.systemFont(ofSize: 10, weight: .semibold)
		linechart.xAxis.drawGridLinesEnabled = false
		
		linechart.drawBordersEnabled = false
		
		linechart.pinchZoomEnabled = false
		return linechart
	}()
	
	var chartView: UIView = {
		var view = UIView()
		return view
	}()
	

	override func loadView() {
		view = UIView()
		view.backgroundColor = .secondarySystemBackground
		view.addSubview(chartView)
		chartView.translatesAutoresizingMaskIntoConstraints = false
		
		[lineChartView, lineChartTitle].forEach {
			chartView.addSubview($0)
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
		chartView.layer.borderColor = UIColor.systemGreen.cgColor
		chartView.layer.borderWidth = 0.5
		chartView.layer.cornerRadius = 10
		chartView.backgroundColor = .systemBackground
		
		NSLayoutConstraint.activate([
			chartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
			chartView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			chartView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			chartView.heightAnchor.constraint(equalToConstant: 350)
		])
		
		
		NSLayoutConstraint.activate([
			lineChartTitle.topAnchor.constraint(equalTo: chartView.safeAreaLayoutGuide.topAnchor),
			lineChartTitle.leadingAnchor.constraint(equalTo: chartView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
			lineChartTitle.trailingAnchor.constraint(equalTo: chartView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
			lineChartTitle.heightAnchor.constraint(equalToConstant: 40),
			lineChartView.topAnchor.constraint(equalTo: lineChartTitle.bottomAnchor, constant: 2),
			lineChartView.leadingAnchor.constraint(equalTo: chartView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
			lineChartView.trailingAnchor.constraint(equalTo: chartView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
			lineChartView.bottomAnchor.constraint(equalTo: chartView.safeAreaLayoutGuide.bottomAnchor, constant: -8)
		])
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

//
//  ViewController.swift
//  DistributionModeling
//
//  Created by Chegelik on 19.09.2021.
//

import Cocoa
import Charts

class ViewController: NSViewController {
    
    // MARK: - Enum
    enum SegmentType: Int {
        case uniform = 0
        case gauss
        case exp
        case gamma
        case triangle
        case sympson
    }

    // MARK: - IBOutlet
    @IBOutlet private weak var firstParamLabel: NSTextField!
    @IBOutlet private weak var secondParamLabel: NSTextField!
    @IBOutlet private weak var firstParamTextField: NSTextField!
    @IBOutlet private weak var secondParamTextField: NSTextField!
    @IBOutlet private weak var segmentControl: NSSegmentedControl!
    @IBOutlet private weak var barChartView: BarChartView!
    
    // MARK: - Properties
    private var lemerSequence: LemerSequence!
    private var distribution: IDistribution?
    private var selectedType: SegmentType = .uniform
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lemerSequence = Sequence(m: 5.0, a: 3.0, r0: 1.0, n: Constants.n)
        self.setupUI()
    }
    
    // MARK: - IBAction
    @IBAction func didTapOnOption(_ sender: NSSegmentedControl) {
        guard let type = SegmentType(rawValue: sender.selectedSegment) else { return }
        switch type {
        case .uniform:
            self.setupParams(firstLabel: "a", secondLabel: "b")
        case .gauss:
            self.setupParams(firstLabel: "m", secondLabel: "σ")
        case .exp:
            self.setupParams(firstLabel: nil, secondLabel: "λ")
        case .gamma:
            self.setupParams(firstLabel: "n", secondLabel: "λ")
        case .triangle:
            self.setupParams(firstLabel: "a", secondLabel: "b")
        case .sympson:
            self.setupParams(firstLabel: "a", secondLabel: "b")
        }
        
        self.barChartView.clearValues()
        self.selectedType = type
    }
    
    @IBAction func didTapOnProcess(_ sender: Any) {
        let firstParam = self.firstParamTextField.doubleValue
        let secondParam = self.secondParamTextField.doubleValue
        
        var resultXArray = [Double]()
        switch self.selectedType {
        case .uniform:
            self.distribution = UniformDistribution(a: firstParam, b: secondParam)
        case .gauss:
            self.distribution = GaussDistribution(m: firstParam, sigma: secondParam)
        case .exp:
            self.distribution = ExpDistribution(lambda: secondParam)
        case .gamma:
            self.distribution = GammaDistribution(n: firstParam, lambda: secondParam)
        case .triangle:
            self.distribution = TriangleDistribution(a: firstParam, b: secondParam)
        case .sympson:
            self.distribution = SympsonDistribution(a: firstParam, b: secondParam)
        }
        resultXArray = distribution?.getXValue(rArray: lemerSequence.getXValues()) ?? []
        self.setupDataSet(with: resultXArray)
    }
    
    // MARK: - Methods
    private func setupParams(firstLabel: String? = nil, secondLabel: String? = nil) {
        self.firstParamLabel.stringValue = firstLabel?.appending(":") ?? "NaN"
        self.secondParamLabel.stringValue = secondLabel?.appending(":") ?? ""
    }
    
    private func setupUI() {
        self.selectedType = .uniform
        self.segmentControl.selectedSegment = 0
        self.setupChart()
    }
    
    private func setupDataSet(with arrayX: [Double]) {
        let barValues = arrayX.getYValues().map { dict -> BarChartDataEntry in
            let midValue = (dict.key.upperBound + dict.key.lowerBound) / 2
            return BarChartDataEntry(x: midValue, y: dict.value)
        }
    
        let data = BarChartData()
        let dataSet = BarChartDataSet(entries: barValues, label: "")
        dataSet.drawValuesEnabled = false
        dataSet.colors = [.blue]

        data.addDataSet(dataSet)
        data.barWidth = arrayX.getIntervalLength()
        self.barChartView.data = data
        //self.setBottomTextFields(seq: arrayX)
    }
    
    private func setupChart() {
        self.barChartView.xAxis.axisMinimum = 0.0
        self.barChartView.xAxis.axisMaximum = 2.0
        self.barChartView.leftAxis.axisMinimum = 0.0
        self.barChartView.rightAxis.enabled = false
        self.barChartView.xAxis.labelPosition = .bottom
        self.barChartView.drawGridBackgroundEnabled = false
    }
}


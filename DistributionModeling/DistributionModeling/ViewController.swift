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
    @IBOutlet private weak var mathTextField: NSTextField!
    @IBOutlet private weak var dispersionTextField: NSTextField!
    @IBOutlet private weak var standardDeviationTextField: NSTextField!
    
    // MARK: - Properties
    private var lemerSequence: LemerSequence!
    private var distribution: IDistribution?
    private var selectedType: SegmentType = .uniform
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lemerSequence = Sequence(m: 1046527.0, a: 65537.0, r0: 32771.0, n: Constants.n)
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
        
        self.resetTextField()
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
        resultXArray = (distribution?.getXValue(rArray: lemerSequence.getXValues()) ?? []).map { $0.rounded(toPlaces: 2)}
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
        self.didTapOnOption(self.segmentControl)
        self.setupChart()
    }
    
    private func setupDataSet(with arrayX: [Double]) {
        
        var min = 0.0
        var max = 1.0
        let barValues = arrayX.getYValues().map { dict -> BarChartDataEntry in
            min = min > dict.key.lowerBound ? dict.key.lowerBound : min
            max = max < dict.key.upperBound ? (dict.key.upperBound + 1) : max
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
        self.setAxis(min: min, max: max)
        self.setBottomTextFields()
    }
    
    private func setBottomTextFields() {
        self.mathTextField.doubleValue = self.distribution?.getMathEx() ?? 0.0
        self.dispersionTextField.doubleValue = self.distribution?.getDispersion() ?? 0.0
        self.standardDeviationTextField.doubleValue = self.distribution?.getStandardDeviation() ?? 0.0
    }
    
    private func resetTextField() {
        self.mathTextField.stringValue = ""
        self.dispersionTextField.stringValue = ""
        self.standardDeviationTextField.stringValue = ""
    }
    
    private func setAxis(min: Double, max: Double) {
        self.barChartView.xAxis.axisMinimum = min
        self.barChartView.xAxis.axisMaximum = max
    }
    
    private func setupChart() {
        self.barChartView.xAxis.axisMinimum = 0.0
        self.barChartView.xAxis.axisMaximum = 5.0
        self.barChartView.leftAxis.axisMinimum = 0.0
        self.barChartView.rightAxis.enabled = false
        self.barChartView.xAxis.labelPosition = .bottom
        self.barChartView.drawGridBackgroundEnabled = false
    }
}

// MARK: Extentions
extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

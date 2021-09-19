//
// Sequence.swift
// ProgramSensor
//
// Created by Ilya Baryko on 10.09.21.
// 
//


import Foundation

typealias PeriodAndAperiodicity = (period: Int32, aperiodicity: Int32)

protocol LemerSequence {
    func getMathExpectation() -> Double
    func getDispersion() -> Double
    func getStandardDeviation() -> Double
    func getXValues() -> [Double]
    func getYValues(totalCounts: Double) -> [Range<Double>: Double]
    func getIntervalLength() -> Double
    func getIndirectSigns() -> Double
    func getPeriodAndAperiodicityLength() -> PeriodAndAperiodicity
}

class Sequence: LemerSequence {
    
    // MARK: - Properties
    private let sequenceGenerator: SequenceGenerator
    private let intervals = 20
    private var sequenceCount: Int
    private var values = [Double]()
    private var xValues = [Double]()
    
    // MARK: - Init
    init(m: Double, a: Double, r0: Double, n: Int) {
        self.sequenceGenerator = SequenceGenerator(m: m, a: a, r0: r0)
        self.sequenceCount = n
        self.values = self.sequenceGenerator.fullSequence(for: n)
        self.xValues = self.values.map { $0 / self.sequenceGenerator.m }
    }
    
    // MARK: - Methods
    func getMathExpectation() -> Double {
        return values.mathExpectation(m: sequenceGenerator.m, n: Double(sequenceCount))
    }
    
    func getDispersion() -> Double {
        return values.dispersion(m: sequenceGenerator.m, n: Double(sequenceCount), mathExpectation: getMathExpectation())
    }
    
    func getStandardDeviation() -> Double {
        return values.standardDeviation(with: getDispersion())
    }
    
    func getXValues() -> [Double] {
        return self.xValues
    }
    
    func getIntervalLength() -> Double {
        guard let max = self.xValues.max(),
              let min = self.xValues.min() else { return 0.0 }
        return (max - min) / Double(intervals)
    }
    
    func getYValues(totalCounts: Double) -> [Range<Double>: Double] {
        guard let min = self.xValues.min() else { return [:] }
        
        let intervalLength = self.getIntervalLength()
        var ordinates: [Range<Double>: Double] = [:]
        
        var initialRange = min
        for _ in 1...intervals {
            let range = initialRange..<(initialRange + intervalLength)
            let mCount = Double(self.xValues.filter({ range.contains($0) }).count)
            ordinates[range] = (mCount / totalCounts)
            initialRange += intervalLength
        }
        
        return ordinates
    }
    
    func getIndirectSigns() -> Double {
        var pairs = 0.0
        stride(from: 0, to: (sequenceCount - 1), by: 2).forEach { index in
            let powFirst = pow(self.xValues[index], 2)
            let powSecond = pow(self.xValues[index + 1], 2)
            if powFirst + powSecond < 1 {
                pairs += 1.0
            }
        }
        
        return 2.0 * pairs / Double(self.sequenceCount)
    }
    
    func getPeriodAndAperiodicityLength() -> PeriodAndAperiodicity {
        let period = getPeriodLength()
        let aperiodicity = getAperiodicityLength(period)
        return (Int32(period), Int32(aperiodicity))
    }
    
    private func getPeriodLength() -> Int {
        guard let xv = self.xValues.last else { return 0 }
        let noIndex = -1
        var firstIndex = noIndex
        
        for (index, value) in self.xValues.enumerated() {
            if value == xv  {
                if firstIndex > noIndex {
                    if value == xv {
                        return index - firstIndex
                    }
                } else {
                    firstIndex = index
                }
            }
        }
        return 0
    }
    
    private func getAperiodicityLength(_ period: Int) -> Int {
        for (index, value) in self.xValues.enumerated() {
            let next = index + period
            if next < (self.sequenceCount - 1) {
                if value == self.xValues[next] {
                    return next
                }
            }
        }
        return 0
    }
}

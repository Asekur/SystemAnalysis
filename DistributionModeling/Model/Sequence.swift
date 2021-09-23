//
// Sequence.swift
// ProgramSensor
//
// Created by Ilya Baryko on 10.09.21.
// 
//


import Foundation

protocol LemerSequence {
    func getXValues() -> [Double]
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
    
    func getXValues() -> [Double] {
        return self.xValues
    }
}

// MARK: - Double array
extension Array where Element == Double {
    func getIntervalLength() -> Double {
        guard let max = self.max(),
              let min = self.min() else { return 0.0 }
        return (max - min) / Double(Constants.intervals)
    }
    
    func getYValues() -> [Range<Double>: Double] {
        guard let min = self.min() else { return [:] }
        
        let intervalLength = self.getIntervalLength()
        var ordinates: [Range<Double>: Double] = [:]
        
        var initialRange = min
        for _ in 1...Constants.intervals {
            let range = initialRange..<(initialRange + intervalLength)
            let mCount = Double(self.filter({ range.contains($0) }).count)
            ordinates[range] = (mCount / Double(Constants.n))
            initialRange += intervalLength
        }
        
        return ordinates
    }
}

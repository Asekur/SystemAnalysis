//
//  SympsonDistribution.swift
//  DistributionModeling
//
//  Created by Chegelik on 23.09.2021.
//

import Foundation

class SympsonDistribution: IDistribution {
    
    // MARK: - Properties
    private var a: Double
    private var b: Double
    private var math: Double = 0.0
    private var dispersion: Double = 0.0
    private var standardDeviation: Double = 0.0
    
    // MARK: - Init
    init(a: Double, b: Double) {
        self.a = a
        self.b = b
    }
    
    // MARK: - Methods
    func getXValue(rArray: [Double]) -> [Double] {
        var sympson = [Double]()
        let uniformDistribution = UniformDistribution(a: a / 2.0, b: b / 2.0)
        let uniformDistributionX = uniformDistribution.getXValue(rArray: rArray)
        for _ in 0..<Constants.n {
            let y = uniformDistributionX[Int.random(in: 0...uniformDistributionX.count - 1)]
            let z = uniformDistributionX[Int.random(in: 0...uniformDistributionX.count - 1)]
            sympson.append(y + z)
        }
        
        self.math = self.calculateMathExpectation(array: sympson)
        self.dispersion = self.calculateDispertion(array: sympson, me: self.math)
        self.standardDeviation = self.calculateStandardDeviation(dispersion: self.dispersion)
        
        return sympson
    }
    
    func getMathEx() -> Double {
        return self.math
    }
    
    func getDispersion() -> Double {
        return self.dispersion
    }
    
    func getStandardDeviation() -> Double {
        return self.standardDeviation
    }
}

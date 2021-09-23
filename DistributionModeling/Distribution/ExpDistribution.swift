//
//  ExpDistribution.swift
//  DistributionModeling
//
//  Created by Chegelik on 23.09.2021.
//

import Foundation

class ExpDistribution: IDistribution {
    
    // MARK: - Properties
    private var lambda: Double
    private var math: Double = 0.0
    private var dispersion: Double = 0.0
    private var standardDeviation: Double = 0.0
    
    // MARK: - Init
    init(lambda: Double) {
        self.lambda = lambda
    }
    
    // MARK: - Methods
    func getXValue(rArray: [Double]) -> [Double] {
        var exponential = [Double]()
        for _ in 0..<Constants.n {
            exponential.append(-log(rArray.randomElement() ?? 1.0) / lambda)
        }
        
        self.math = self.calculateMathExpectation(array: exponential)
        self.dispersion = self.calculateDispertion(array: exponential, me: self.math)
        self.standardDeviation = self.calculateStandardDeviation(dispersion: self.dispersion)
        
        return exponential
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

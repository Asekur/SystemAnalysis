//
// GammaDistribution.swift
// DistributionModeling
//
// Created by Ilya Baryko on 22.09.21.
// 
//


import Foundation

class GammaDistribution: IDistribution {
    
    // MARK: - Properties
    private var n: Int
    private var lambda: Double
    private var math: Double = 0.0
    private var dispersion: Double = 0.0
    private var standardDeviation: Double = 0.0
    
    // MARK: - Init
    init(n: Double, lambda: Double) {
        self.n = Int(n)
        self.lambda = lambda
    }
    
    // MARK: - Methods
    func getXValue(rArray: [Double]) -> [Double] {
        var gamma = [Double]()
        for _ in 0..<Constants.n {
            var tmpMulR = 1.0
            for _ in 0..<n {
                tmpMulR *= rArray.randomElement() ?? 1.0
            }
            gamma.append(-log(tmpMulR) / lambda)
        }
        
        self.math = self.calculateMathExpectation(array: gamma)
        self.dispersion = self.calculateDispertion(array: gamma, me: self.math)
        self.standardDeviation = self.calculateStandardDeviation(dispersion: self.dispersion)
        
        return gamma
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

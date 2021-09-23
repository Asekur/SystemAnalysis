//
// GaussDistribution.swift
// DistributionModeling
//
// Created by Ilya Baryko on 22.09.21.
// 
//


import Foundation

class GaussDistribution: IDistribution {
    
    // MARK: - Properties
    private var m: Double
    private var sigma: Double
    private var math: Double = 0.0
    private var dispersion: Double = 0.0
    private var standardDeviation: Double = 0.0
    
    // MARK: - Init
    init(m: Double, sigma: Double) {
        self.m = m
        self.sigma = sigma
    }
    
    // MARK: - Methods
    func getXValue(rArray: [Double]) -> [Double] {
        let amountR = 6
        var gauss = [Double]()
        for _ in 0..<Constants.n {
            var tmpSumR = 0.0
            for _ in 0..<amountR {
                tmpSumR += (rArray.randomElement() ?? 1.0)
            }
            let subValue = (tmpSumR - Double(amountR) / 2.0)
            gauss.append(m + sigma * sqrt(12.0 / Double(amountR)) * subValue)
        }
        
        self.math = self.calculateMathExpectation(array: gauss)
        self.dispersion = self.calculateDispertion(array: gauss, me: self.math)
        self.standardDeviation = self.calculateStandardDeviation(dispersion: self.dispersion)
        
        return gauss
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

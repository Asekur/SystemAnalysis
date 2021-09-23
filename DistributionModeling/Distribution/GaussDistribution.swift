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
        return gauss
    }
    
    func getMathEx() -> Double {
        return m
    }
    
    func getDispersion() -> Double {
        return pow(sigma, 2.0)
    }
    
    func getStandardDeviation() -> Double {
        return sigma
    }
}

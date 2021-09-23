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
        return gamma
    }
    
    func getMathEx() -> Double {
        return Double(n) / lambda
    }
    
    func getDispersion() -> Double {
        return Double(n) / pow(lambda, 2.0)
    }
    
    func getStandardDeviation() -> Double {
        return sqrt(Double(n)) / lambda
    }
}

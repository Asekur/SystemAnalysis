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
    func getValue(x: Double) -> Double {
        return x > 0 ? pow(lambda, Double(n)) / Double((n - 1).factorial()) * pow(x, Double(n - 1)) * exp(-1.0 * lambda * x)
                     : 0.0
    }
}

extension Int {
    func factorial() -> Int {
        guard self != 0 else { return 1 }

        return (1...self).reduce(1, { $0 * $1 })
    }
}

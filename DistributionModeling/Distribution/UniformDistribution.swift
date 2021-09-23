//
// UniformDistribution.swift
// DistributionModeling
//
// Created by Ilya Baryko on 22.09.21.
// 
//


import Foundation

class UniformDistribution: IDistribution {
    
    // MARK: - Properties
    private var a: Double
    private var b: Double
    
    // MARK: - Init
    init(a: Double, b: Double) {
        self.a = a
        self.b = b
    }
    
    // MARK: - Methods
    func getXValue(rArray: [Double]) -> [Double] {
        var uniform = [Double]()
        for index in 0..<Constants.n {
            uniform.append(a + (b - a) * rArray[index])
        }
        return uniform
    }
    
    func getMathEx() -> Double {
        return (a + b) / 2.0
    }
    
    func getDispersion() -> Double {
        return pow(b - a, 2.0) / 12.0
    }
    
    func getStandardDeviation() -> Double {
        return (b - a) / sqrt(12.0)
    }
}

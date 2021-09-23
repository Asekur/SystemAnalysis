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
        var uniform = [Double]()
        for index in 0..<Constants.n {
            uniform.append(a + (b - a) * rArray[index])
        }
        
        self.math = self.calculateMathExpectation(array: uniform)
        self.dispersion = self.calculateDispertion(array: uniform, me: self.math)
        self.standardDeviation = self.calculateStandardDeviation(dispersion: self.dispersion)
        
        return uniform
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

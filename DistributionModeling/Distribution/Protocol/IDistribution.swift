//
// IDistribution.swift
// DistributionModeling
//
// Created by Ilya Baryko on 22.09.21.
// 
//


import Foundation

protocol IDistribution {
    func getXValue(rArray: [Double]) -> [Double]
    func getMathEx() -> Double
    func getDispersion() -> Double
    func getStandardDeviation() -> Double
}

extension IDistribution {
    func calculateMathExpectation(array: [Double]) -> Double {
        return array.reduce(0, +) / Double(Constants.n)
    }
    
    func calculateDispertion(array: [Double], me: Double) -> Double {
        var result = 0.0
        array.forEach {
            let toPow = $0 - me
            result += pow(toPow, 2)
        }
        return  result / Double(Constants.n)
    }
    
    func calculateStandardDeviation(dispersion: Double) -> Double {
        return sqrt(dispersion)
    }
}

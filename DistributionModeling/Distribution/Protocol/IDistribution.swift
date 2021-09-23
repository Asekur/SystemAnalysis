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

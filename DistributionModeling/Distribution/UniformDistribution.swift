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
    func getValue(x: Double) -> Double {
        let range = a > b ? (b...a) : (a...b)
        if range.contains(x) {
            return (x - a) / (b - a)
        } else if x < a {
            return 0
        } else {
            return 1
        }
//        return range.contains(x) ? 1 / (b - a) : 0
    }
}

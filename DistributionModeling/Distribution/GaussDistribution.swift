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
    func getValue(x: Double) -> Double {
        let a = (1 / sigma * sqrt(2.0 * Double.pi))
        let b = exp(-(pow((x - m), 2) / 2 * pow(sigma, 2)))
        return pow(a, b)
    }
}

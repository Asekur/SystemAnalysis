//
//  TriangleDistribution.swift
//  DistributionModeling
//
//  Created by Chegelik on 23.09.2021.
//

import Foundation

class TriangleDistribution: IDistribution {
    
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
        var triangle = [Double]()
        for _ in 0..<Constants.n {
            let tmpR1 = (rArray.randomElement() ?? 1.0)
            let tmpR2 = (rArray.randomElement() ?? 1.0)
            triangle.append(a + (b - a) * max(tmpR1, tmpR2))
        }
        
        self.math = self.calculateMathExpectation(array: triangle)
        self.dispersion = self.calculateDispertion(array: triangle, me: self.math)
        self.standardDeviation = self.calculateStandardDeviation(dispersion: self.dispersion)
        
        return triangle
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

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
        return triangle
    }
    
    func getMathEx() -> Double {
        return 0.0
    }
    
    func getDispersion() -> Double {
        return 0.0
    }
    
    func getStandardDeviation() -> Double {
        return 0.0
    }
}

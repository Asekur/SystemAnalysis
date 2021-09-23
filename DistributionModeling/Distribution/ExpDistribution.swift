//
//  ExpDistribution.swift
//  DistributionModeling
//
//  Created by Chegelik on 23.09.2021.
//

import Foundation

class ExpDistribution: IDistribution {
    
    // MARK: - Properties
    private var lambda: Double
    
    // MARK: - Init
    init(lambda: Double) {
        self.lambda = lambda
    }
    
    // MARK: - Methods
    func getXValue(rArray: [Double]) -> [Double] {
        var exponential = [Double]()
        for _ in 0..<Constants.n {
            exponential.append(-log(rArray.randomElement() ?? 1.0) / lambda)
        }
        return exponential
    }
    
    func getMathEx() -> Double {
        return 1.0 / lambda
    }
    
    func getDispersion() -> Double {
        return 1.0 / pow(lambda, 2.0)
    }
    
    func getStandardDeviation() -> Double {
        return 1.0 / lambda
    }
}

//
//  Calculations.swift
//  DistributionModeling
//
//  Created by Chegelik on 19.09.2021.
//

import Foundation

protocol Sequences {
    static func getUniformDistribuion(_ rArray: [Double], _ a: Double, _ b: Double) -> [Double]
    static func getGaussDistribution(_ rArray: [Double], _ m: Double, _ sigma: Double) -> [Double]
    static func getExponentialDistribution(_ rArray: [Double], _ lambda: Double) -> [Double]
    static func getGammaDistribution(_ rArray: [Double], _ ƞ: Int, _ lambda: Double) -> [Double]
    static func getTriangleDistribution(_ rArray: [Double], _ a: Double, _ b: Double) -> [Double]
    static func getSympsonDistribution(_ rArray: [Double], _ a: Double, _ b: Double) -> [Double]
}

class SequencesDistribution: Sequences {
    
    static func getUniformDistribuion(_ rArray: [Double], _ a: Double, _ b: Double) -> [Double] {
        var uniform = [Double]()
        for _ in 0..<Constants.n {
            uniform.append(a + (b - a) * (rArray.randomElement() ?? 1.0))
        }
        return uniform
    }
    
    static func getGaussDistribution(_ rArray: [Double], _ m: Double, _ sigma: Double) -> [Double] {
        let amountR = 6
        var gauss = [Double]()
        for _ in 0..<Constants.n {
            var tmpSumR = 0.0
            for _ in 0..<amountR {
                tmpSumR += (rArray.randomElement() ?? 1.0)
            }
            let subValue = (tmpSumR - Double(amountR) / 2.0)
            gauss.append(m + sigma * sqrt(12.0 / Double(amountR)) * subValue)
        }
        return gauss
    }
    
    static func getExponentialDistribution(_ rArray: [Double], _ lambda: Double) -> [Double] {
        var exponential = [Double]()
        for _ in 0..<Constants.n {
            exponential.append(-log(rArray.randomElement() ?? 1.0) / lambda)
        }
        return exponential
    }
    
    static func getGammaDistribution(_ rArray: [Double], _ ƞ: Int, _ lambda: Double) -> [Double] {
        var gamma = [Double]()
        for _ in 0..<Constants.n {
            var tmpMulR = 1.0
            for _ in 0..<ƞ {
                tmpMulR *= rArray.randomElement() ?? 1.0
            }
            gamma.append(-log(tmpMulR) / lambda)
        }
        return gamma
    }
    
    static func getTriangleDistribution(_ rArray: [Double], _ a: Double, _ b: Double) -> [Double] {
        var triangle = [Double]()
        for _ in 0..<Constants.n {
            let tmpR1 = (rArray.randomElement() ?? 1.0)
            let tmpR2 = (rArray.randomElement() ?? 1.0)
            triangle.append(a + (b - a) * max(tmpR1, tmpR2))
        }
        return triangle
    }
    
    static func getSympsonDistribution(_ rArray: [Double], _ a: Double, _ b: Double) -> [Double] {
        var sympson = [Double]()
        let uniformDistribution = getUniformDistribuion(rArray, a / 2.0, b / 2.0)
        for _ in 0..<Constants.n {
            let y = uniformDistribution[Int.random(in: 0...uniformDistribution.count - 1)]
            let z = uniformDistribution[Int.random(in: 0...uniformDistribution.count - 1)]
            sympson.append(y + z)
        }
        return sympson
    }
}

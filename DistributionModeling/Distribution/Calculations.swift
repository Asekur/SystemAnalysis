//
//  Calculations.swift
//  DistributionModeling
//
//  Created by Chegelik on 19.09.2021.
//

import Foundation

protocol Sequences {
    func getUniformDistribuion(_ rArray: [Double], _ a: Double, _ b: Double) -> [Double]
    func getGaussDistribution(_ rArray: [Double], _ m: Double, _ σ: Double) -> [Double]
    func getExponentialDistribution(_ rArray: [Double], _ λ: Double) -> [Double]
    func getGammaDistribution(_ rArray: [Double], _ ƞ: Int, _ λ: Double) -> [Double]
    func getTriangleDistribution(_ rArray: [Double], _ a: Double, _ b: Double) -> [Double]
    func getSympsonDistribution(_ rArray: [Double], _ a: Double, _ b: Double) -> [Double]
}

class SequencesDistribution: Sequences {
    
    let n = 150000
    
    func getUniformDistribuion(_ rArray: [Double], _ a: Double, _ b: Double) -> [Double] {
        var uniform = [Double]()
        for index in 0..<n {
            uniform.append(a + (b - a) * rArray[index])
        }
        return uniform
    }
    
    func getGaussDistribution(_ rArray: [Double], _ m: Double, _ σ: Double) -> [Double] {
        let amountR = 6
        var gauss = [Double]()
        for index in 0..<n {
            var tmpSumR = 0.0
            for j in 0..<amountR {
                tmpSumR += rArray[(index + j) / n]
            }
            let subValue = (tmpSumR - Double(amountR) / 2.0)
            gauss.append(m + σ * sqrt(12.0 / Double(amountR)) * subValue)
        }
        return gauss
    }
    
    func getExponentialDistribution(_ rArray: [Double], _ λ: Double) -> [Double] {
        var exponential = [Double]()
        for index in 0..<n {
            exponential.append(-log(rArray[index]) / λ)
        }
        return exponential
    }
    
    func getGammaDistribution(_ rArray: [Double], _ ƞ: Int, _ λ: Double) -> [Double] {
        var gamma = [Double]()
        for index in 0..<n {
            var tmpMulR = 1.0
            for j in 0..<ƞ {
                tmpMulR *= rArray[(index + j) / n]
            }
            gamma.append(-log(tmpMulR) / λ)
        }
        return gamma
    }
    
    func getTriangleDistribution(_ rArray: [Double], _ a: Double, _ b: Double) -> [Double] {
        var triangle = [Double]()
        for index in 0..<n {
            let tmpR1 = rArray[index]
            let tmpR2 = rArray[index + 1]
            triangle.append(a + (b - a) * max(tmpR1, tmpR2))
        }
        return triangle
    }
    
    func getSympsonDistribution(_ rArray: [Double], _ a: Double, _ b: Double) -> [Double] {
        var sympson = [Double]()
        let uniformDistribution = getUniformDistribuion(rArray, a / 2.0, b / 2.0)
        for _ in 0..<n {
            let y = uniformDistribution[Int.random(in: 0...uniformDistribution.count - 1)]
            let z = uniformDistribution[Int.random(in: 0...uniformDistribution.count - 1)]
            sympson.append(y + z)
        }
        return sympson
    }
}

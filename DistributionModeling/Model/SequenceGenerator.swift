//
// SequenceGenerator.swift
// ProgramSensor
//
// Created by Ilya Baryko on 10.09.21.
// 
//


import Foundation

protocol GeneratedSequence {
    func nextValue() -> Double
    func fullSequence(for n: Int) -> [Double]
}

class SequenceGenerator: GeneratedSequence {
    
    // MARK: - Properties
    var m: Double
    var a: Double
    var r0: Double
    var ri: Double
    
    // MARK: - Init
    init(m: Double, a: Double, r0: Double) {
        self.m = m
        self.a = a
        self.r0 = r0
        self.ri = r0
    }
    
    // MARK: - Methods
    func nextValue() -> Double {
        self.ri = (a * ri).truncatingRemainder(dividingBy: m)
        return self.ri
    }
    
    func fullSequence(for n: Int) -> [Double] {
        var sequence = [Double]()
        for _ in 0...n {
            sequence.append(self.nextValue())
        }
        return sequence
    }
}

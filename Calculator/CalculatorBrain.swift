//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Ken Van den Enden on 16/8/17.
//  Copyright © 2017 Ken Van den Enden. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private var accumulator: Double = 0.0
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    let operations: Dictionary<String, Operation> = [
        "C" : Operation.Constant(0.0),
        "π" : Operation.Constant(Double.pi),
        "e" : Operation.Constant(M_E),
        
        "±" : Operation.UnaryOperation({ -$0 }),
        "%" : Operation.UnaryOperation({ $0 / 100 }),
        
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "−" : Operation.BinaryOperation({ $0 - $1 }),
        "×" : Operation.BinaryOperation({ $0 * $1 }),
        "÷" : Operation.BinaryOperation({ $0 / $1 }),
        
        "=" : Operation.Equals
    ]
    
    func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                performPendingOperation()
                pendingBinaryOperation = PendingBinaryOperation(symbol: symbol, operand: accumulator, function: function)
            case .Equals:
                performPendingOperation()
            }
        }
    }
    
    private func performPendingOperation() {
        if let operation = pendingBinaryOperation {
            accumulator = operation.function(operation.operand, accumulator)
            pendingBinaryOperation = nil
        }
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
    var pendingOperation: String? {
        get {
            return pendingBinaryOperation?.symbol
        }
    }
    
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    struct PendingBinaryOperation {
        var symbol: String
        var operand: Double
        var function: (Double, Double) -> Double
    }
}

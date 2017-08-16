//
//  ViewController.swift
//  Calculator
//
//  Created by Ken Van den Enden on 16/8/17.
//  Copyright © 2017 Ken Van den Enden. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        readBrain()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var brain = CalculatorBrain()

    @IBAction func operation(_ sender: UIButton) {
        if let currentOperation = sender.currentTitle {
            if let operand = result {
                brain.setOperand(operand)
            }
            brain.performOperation(currentOperation)
            readBrain()
            
            newOperand = true
        }
    }
    
    private func readBrain() {
        result = brain.result
        pendingOperation = brain.pendingOperation
    }

    @IBAction func digit(_ sender: UIButton) {
        if let currentDigit = sender.currentTitle {
            if newOperand {
                newDigit(currentDigit)
            } else {
                appendDigit(currentDigit)
            }
            newOperand = false
        }
    }
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var operationLabel: UILabel!
    
    private var newOperand = true
    
    private var result: Double? {
        get {
            if let text = resultLabel.text {
                return Double(text)
            } else {
                return nil
            }
        }
        set {
            if let val = newValue {
                if round(val) == val {
                    resultLabel.text = String(Int(val))
                } else {
                    resultLabel.text = String(val)
                }
            } else {
                resultLabel.text = "Error"
            }
        }
    }
    
    private var pendingOperation: String? {
        get {
            return operationLabel.text
        }
        set {
            operationLabel.text = newValue ?? " "
        }
    }
    
    private func appendDigit(_ digit: String) {
        if let currentText = resultLabel.text {
            resultLabel.text = currentText + digit
        } else {
            resultLabel.text = digit
        }
    }
    
    private func newDigit(_ digit: String) {
        resultLabel.text = digit
    }
}


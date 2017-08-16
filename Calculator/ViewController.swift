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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var brain = CalculatorBrain()

    @IBAction func operation(_ sender: UIButton) {
        if let currentOperation = sender.currentTitle {
            brain.setOperand(result)
            brain.performOperation(currentOperation)
            
            result = brain.result
            pendingOperation = brain.pendingOperation
            newOperand = true
        }
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
    
    private var result: Double {
        get {
            if let text = resultLabel.text, let val = Double(text) {
                return val
            } else {
                return 0.0
            }
        }
        set {
            if round(newValue) == newValue {
                resultLabel.text = String(Int(newValue))
            } else {
                resultLabel.text = String(newValue)
            }
        }
    }
    
    private var pendingOperation: String? {
        get {
            return operationLabel.text
        }
        set {
            operationLabel.text = newValue
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


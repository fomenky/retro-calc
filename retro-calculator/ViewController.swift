//
//  ViewController.swift
//  retro-calculator
//
//  Created by AceGod on 8/9/16.
//  Copyright © 2016 AceGod. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case divide = "/"
        case multiply = "*"
        case subtract = "-"
        case add = "+"
        case empty = "Empty"
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var btnSound: AVAudioPlayer!
    var anySelectedNumber: String = ""
    var firstSelectedNumber = ""
    var secondSelectedNumber = ""
    var currentOperation: Operation = Operation.empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }

    @IBAction func numberPressed (btn: UIButton){
        playSound()
        
        anySelectedNumber += "\(btn.tag)"
        outputLabel.text = anySelectedNumber
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.divide)
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.add)
    }
    
    @IBAction func onEqualtoPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.empty {
            
            // Fixing bug: incase a user selects an operator 
            // then decides to compute the result by pressing another operator
            if anySelectedNumber != "" {
                secondSelectedNumber = anySelectedNumber
                anySelectedNumber = ""
                
                //Do the Math
                if currentOperation == Operation.divide {
                    result = "\(Double(firstSelectedNumber)! / Double(secondSelectedNumber)!)"
                } else if currentOperation == Operation.multiply {
                    result = "\(Double(firstSelectedNumber)! * Double(secondSelectedNumber)!)"
                } else if currentOperation == Operation.subtract {
                    result = "\(Double(firstSelectedNumber)! - Double(secondSelectedNumber)!)"
                } else if currentOperation == Operation.add {
                    result = "\(Double(firstSelectedNumber)! + Double(secondSelectedNumber)!)"
                }
                
                //Store result on lefthandSide value for future computations
                firstSelectedNumber = result
                outputLabel.text = result //Print result
                
                
                currentOperation = op
            }
            
            
        }else {
            firstSelectedNumber = anySelectedNumber
            anySelectedNumber = ""
            currentOperation = op
        }
    }
    
    func playSound () {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
}


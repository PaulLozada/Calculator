//
//  ViewController.swift
//  Calculator
//
//  Created by Paul Lozada on 2016-02-18.
//  Copyright © 2016 Paul Lozada. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var btnSound : AVAudioPlayer!
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation = Operation.Empty

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Minus = "-"
        case Empty = "Empty"
    }
    
    func processOperation(op:Operation){
        playSound()
        
        if currentOperation != .Empty {
            
            if runningNumber != "" {
                rightValue = runningNumber
                runningNumber = ""
                
                if currentOperation == .Multiply {
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                } else if currentOperation == .Divide{
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                } else if currentOperation == .Add {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                } else if currentOperation == .Minus {
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                }
                
                leftValue = result
                outputLabel.text = result
                currentOperation = op
            }
            
        } else {
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    
    
    @IBAction func numberPressed(btn: UIButton!){
        runningNumber += "\(btn.tag)"
        outputLabel.text = runningNumber
        }
    
    @IBAction func onDividePressed(sender: UIButton) {
        processOperation(.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: UIButton) {
        processOperation(.Multiply)
    }
    
    @IBAction func onMinusPressed(sender: UIButton) {
        processOperation(.Minus)
    }
    
    @IBAction func onPlusPressed(sender: AnyObject) {
        processOperation(.Add)
    }
    @IBAction func onEqualPressed(sender: UIButton) {
        processOperation(currentOperation)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            btnSound = try AVAudioPlayer(contentsOfURL: soundUrl)
        } catch {
            print("No file found")
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


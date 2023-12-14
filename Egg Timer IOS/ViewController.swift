//
//  ViewController.swift
//  Egg Timer IOS
//
//  Created by Matthew Colson on 12/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    let cookTimes = [
        "Soft" : 300,
        "Medium" : 480,
        "Hard" : 720,
    ]
    
    var timer = Timer()
    
    var startTime = 0
    var timeExpired = 0
    var timeLeft = 0

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerControlButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = "0"
    }

    @IBAction func hardnessButtonPressed(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        startTime = cookTimes[hardness]!
        timeExpired = 0
        timeLeft = startTime - timeExpired
        timerControlButton.setTitle("Start", for: .normal)
        updateUI()
    }
    
    @IBAction func timerControlButtonPressed(_ sender: UIButton) {
        var state = sender.currentTitle!
        
        switch state {
            case "Start":
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeLeft), userInfo: nil, repeats: true)
                timerControlButton.setTitle("Pause", for: .normal)
            case "Pause":
            timer.invalidate()
            timerControlButton.setTitle("Restart", for: .normal)
            case "Restart":
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeLeft), userInfo: nil, repeats: true)
                timerControlButton.setTitle("Pause", for: .normal)
            default:
                break
        }
        
    }
    
    func updateUI() {
        var textToDisplay = ""
        
        if timeLeft > 0 {
            let minutes = timeLeft / 60
            let seconds = timeLeft % 60
            if minutes > 0 {
                textToDisplay = "\(minutes):"
            }
            
            textToDisplay += String(format: "%02d", seconds)
        } else {
            timerControlButton.setTitle("Start", for: .normal)
            textToDisplay = "DONE!!!"
        }
        
        timerLabel.text = textToDisplay
    }
    
    
    @objc func updateTimeLeft() {
        timeExpired += 1
        timeLeft = startTime - timeExpired
        
        if timeLeft <= 0 {
            timeLeft = 0
            timeExpired = 0
            timer.invalidate()
        }
        
        updateUI()
    }
}


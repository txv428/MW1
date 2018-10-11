//
//  ViewController.swift
//  Timer
//
//  Created by OSU App Center on 10/6/18.
//  Copyright © 2018 OSU App Center. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var startSelected: UIButton!
    
    @IBOutlet weak var pauseSelected: UIButton!
    
    @IBOutlet weak var resetSelected: UIButton!
    
    @IBOutlet weak var resetTextSelected: UIButton!
    
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    @IBOutlet weak var lapNumberLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UIButton!
    
    @IBOutlet var doubleTap: UITapGestureRecognizer!
    
    var times : [Double] = []
    var laptimeString : [String] = []
    var laps : [Int] = []
    var lapNumber = 0
    var milliseconds = 0
    var totalSeconds = 0
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pauseSelected.isHidden = true
        resetTextSelected.isHidden = true
//        doubleTap.require(toFail: startSelected)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setToolbarHidden(true, animated: true)
    }
    
    @IBAction func startTouched(_ sender: UIButton) {
        if isTimerRunning == false {
            runTimer()
            self.startSelected.isHidden = true
            self.pauseSelected.isHidden = false
            self.resumeTapped = false
            pauseSelected.setBackgroundImage(UIImage(named: "stop.png"), for: .normal)
            self.pauseSelected.setTitle("Pause",for: .normal)
            titleLabel.isHidden = true
            resetTextSelected.isHidden = false
//            resetTextSelected.setTitle("New Leap", for: .normal)
        }
        
        if lapNumber == 0 {
            self.lapNumber += 1
            self.lapNumberLabel.text = "\(lapNumber)"
        }
    }
    
    @IBAction func pauseTouched(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            pauseSelected.setBackgroundImage(UIImage(named: "start.png"), for: .normal)
            self.pauseSelected.setTitle("Resume", for: .normal)
            titleLabel.isHidden = false
            resetTextSelected.isHidden = true
//            resetTextSelected.setTitle("Take a Leap", for: .normal)
        } else {
            runTimer()
            self.resumeTapped = false
            pauseSelected.setBackgroundImage(UIImage(named: "stop.png"), for: .normal)
            self.pauseSelected.setTitle("Pause",for: .normal)
            titleLabel.isHidden = true
            resetTextSelected.isHidden = false
//            resetTextSelected.setTitle("New Leap", for: .normal)
        }
    }
    
    @IBAction func resetTouched(_ sender: UIButton) {
        totalTimeLabel.text = timeString(time: TimeInterval(totalSeconds))
        times.append(Double(milliseconds))
        print(times)
        laptimeString.append(timeString(time: TimeInterval(milliseconds)))
        timer.invalidate()
        milliseconds = 0
        timerLabel.text = timeString(time: TimeInterval(milliseconds))
        isTimerRunning = false
        pauseSelected.isHidden = true
        startSelected.isHidden = false
        lapNumber += 1
        laps.append(lapNumber)
        self.lapNumberLabel.text = "\(lapNumber)"
//        resetTextSelected.setTitle("Take a Leap", for: .normal)
        
        if isTimerRunning == false {
            runTimer()
            self.startSelected.isHidden = true
            self.pauseSelected.isHidden = false
            self.resumeTapped = false
            pauseSelected.setBackgroundImage(UIImage(named: "stop.png"), for: .normal)
            self.pauseSelected.setTitle("Pause",for: .normal)
            titleLabel.isHidden = true
            resetTextSelected.isHidden = false
//            resetTextSelected.setTitle("New Leap", for: .normal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lapTable" {
            if let vc = segue.destination as? TableViewController {
                vc.lapArray = laps
                vc.lapTimesArray = times
                vc.lapTimesString = laptimeString
            }
        }
    }
    
    @IBAction func DoubleTapGesture(_ sender: UITapGestureRecognizer) {
        milliseconds = 0
        totalSeconds = 0
        laptimeString = []
        laps = []
    }
    
    @IBAction func TableView(_ sender: UIButton) {
        self.performSegue(withIdentifier: "lapTable", sender: self)
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        
        isTimerRunning = true
        pauseSelected.isHidden = false
    }
    
    @objc func updateTimer() {
            milliseconds += 1
            totalSeconds += 1
            timerLabel.text = timeString(time: TimeInterval(milliseconds))
            totalTimeLabel.text = timeString(time: TimeInterval(totalSeconds))
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 36000
        let minutes = Int(time) / 600 % 60
        let seconds = Int(time) / 10 % 60
        let milliseconds = Int(time) % 10
        return String(format:"%02i:%02i:%02i.%01i", hours, minutes, seconds, milliseconds)
    }
}


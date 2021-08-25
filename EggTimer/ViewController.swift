//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    // create a dictinary
    let eggTimes = ["Soft": 10, "Medium": 15, "Hard": 20]
    
    var totalTime = 0
    var secondsPassed = 0
    
    var timer = Timer()
    var player: AVAudioPlayer!

    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLable: UILabel!
    
    @IBAction func eggSelect(_ sender: UIButton) {
        progressBar.progress = 0.0
        // 1.0 est le defaut value of max progress
        
        timer.invalidate()
        let hardness = sender.currentTitle ?? "Medium"
        titleLable.text = hardness
        //! means sure there is value
        totalTime =  eggTimes[hardness]!
        secondsPassed = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if secondsPassed < totalTime {
            //print("\(secondsRemaining) seconds.")
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = percentageProgress
        }else{
            timer.invalidate()
            titleLable.text = "DONE"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
    
}

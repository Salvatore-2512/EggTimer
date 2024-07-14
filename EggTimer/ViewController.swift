//
//  ViewController.swift
//  EggTimer
//
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft":5, "Medium": 7, "Hard": 12]
    
    var timer = Timer()
    var secondsPassed = 0
    var totalTime = 0
    var player: AVAudioPlayer?
    

    @IBOutlet weak var upperText: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        upperText.text = "How do you like your eggs?"
        progressBar.progress = 0.0
        secondsPassed = 0
        totalTime = 0
        
    }
   
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        totalTime = 0
        secondsPassed = 0
        progressBar.progress = 0.0
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        upperText.text = "How do you like your eggs?"
        secondsPassed = 0
        
        
        print(eggTimes[hardness] ?? 0)
        
        upperText.text = "cooking..."
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateCounter() {
        
        if secondsPassed < totalTime {
            
            secondsPassed+=1
            progressBar.progress = Float(secondsPassed)/Float(totalTime)
            print("\(Float(secondsPassed)/Float(totalTime))")
        }
        if secondsPassed == totalTime{
            timer.invalidate()
            upperText.text = "DONE!"
            playSound()
        }
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}

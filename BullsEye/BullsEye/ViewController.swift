//
//  ViewController.swift
//  BullsEye
//
//  Created by Ryan Bland on 5/23/18.
//  Copyright © 2018 training. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel : UILabel!
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var roundLabel : UILabel!
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert() {
        let diff = abs(currentValue - targetValue)
        var points = 100 - diff
        
        
        let title : String
        if diff == 0 {
            title = "Perfect!"
            points += 100
        }
        else if diff < 5 {
            title = "You almost had it!"
            if diff == 1 {
                points += 50
            }
        }
        else if diff < 10 {
            title = "You were so close!"
        }
        else if diff < 50 {
            title = "You need some more practice at this..."
        }
        else {
            title = "Are you even trying to hit the target?"
        }
        score += points
        
        let message = "You scored \(points) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: {
                                        action in self.startNewRound()
                                   }
        )
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved( _ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    @IBAction func startNewGame() {
        round = 0
        score = 0
        startNewRound()
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
}


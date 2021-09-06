//
//  ViewController.swift
//  DicePlay
//
//  Created by Kyle Lei on 2021/9/2.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let player = AVPlayer()
    

    @IBOutlet var diceImage: [UIImageView]!
    @IBOutlet var totalLabel: UILabel!
    
     
    
     
    func animation() ->CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        
        animation.fromValue = 0
        animation.toValue = CGFloat.pi*6
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
      
           
        return animation
    }
     
        
    func shake() {
        let fileUrl = Bundle.main.url(forResource: "DicePlay", withExtension: "mp3")!
        let playItem = AVPlayerItem(url: fileUrl)
        player.replaceCurrentItem(with: playItem
        )
        let time = CMTime(value: 1, timescale: 1)
        player.seek(to: time)
        player.play()
        
        for dice in diceImage {
            dice.layer.add(animation(), forKey: nil)
            
        }
    }
    
    @objc func changeNumber() {
        var totalValue = 0
        for dice in diceImage {
            let number = Int.random(in: 1...6)
            let image = UIImage(systemName: "die.face.\(number).fill")
            dice.image = image
            totalValue += number
            totalLabel.text = String(totalValue)
        }
    }
    
        

    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
       if motion == .motionShake {
           shake()
       }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    
        
    }
    
    
    @IBAction func shakeDice(_ sender: Any) {
        shake()
        
        perform(#selector(changeNumber), with: nil, afterDelay: 1)
    }

}

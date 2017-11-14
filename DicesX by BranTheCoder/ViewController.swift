//
//  ViewController.swift
//  DicesX by BranTheCoder
//
//  Created by Branislav on 25/10/2017.
//  Copyright © 2017 Branislav. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
   
    var player: AVAudioPlayer?
    
    var randomDiceIndex1 : Int = 0
    var randomDiceIndex2 : Int = 0
    
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        updateImages()
    }

    func updateImages() {
    randomDiceIndex1 = Int(arc4random_uniform(6)+1)
    randomDiceIndex2 = Int(arc4random_uniform(6)+1)
    
    
    diceImageView1.image = UIImage(named: "dice" + String(randomDiceIndex1))
    diceImageView2.image = UIImage(named: "dice" + String(randomDiceIndex2))
    playSound()
    }
    func playSound() {
        guard let url = Bundle.main.url(forResource: "roll", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            
         
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
        guard let player = player else { return }
       
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?){
        updateImages()
    }
}


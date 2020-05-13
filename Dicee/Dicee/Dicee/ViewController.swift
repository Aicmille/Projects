//
//  ViewController.swift
//  Dicee
//
//  Created by Aidan Miller on 3/25/19.
//  Copyright © 2019 Aidan Miller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var randomDiceIndex1 : Int = 0
    var randomDiceIndex2 : Int = 0
    
    let diceArray = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    
    @IBOutlet weak var leftDice: UIImageView!
    
    @IBOutlet weak var rightDice: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDiceImages()
    }

    @IBAction func RollButton(_ sender: UIButton) {
        
        updateDiceImages()
    }
    
    func updateDiceImages(){
        
        randomDiceIndex1 = Int(arc4random_uniform(6))
        randomDiceIndex2 = Int(arc4random_uniform(6))
        
        leftDice.image = UIImage(named: diceArray[randomDiceIndex1])
        rightDice.image = UIImage(named: diceArray[randomDiceIndex2])
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateDiceImages()
    }
    
}


//
//  GameOverViewController.swift
//  LocationGame_ios
//
//  Created by Student10 on 18/06/2023.
//

import UIKit

class GameOverViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    @IBOutlet weak var winnerName_Label: UILabel!
    
    @IBOutlet weak var winnerScore_Label: UILabel!
    
    @IBOutlet weak var BackToManu_BTN: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        winnerName_Label.text = "Winner: " + getName()
        winnerScore_Label.text = "Score: " + getScore()
        
        
    }
    
    
    @IBAction func onBackToMenuClicked(_ sender: Any) {
        let homePage_vc = storyboard?.instantiateViewController(identifier: "homePage_vc") as! ViewController
        present(homePage_vc, animated: true)
    }
    
    func getName() -> String! {
        let name = defaults.string(forKey: GameViewController.Keys.key_winner)
        return name!
    }

    func getScore() -> String{
        let score = defaults.string(forKey: GameViewController.Keys.key_points)
        return score!
    }
}

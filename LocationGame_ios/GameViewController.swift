//
//  GameViewController.swift
//  LocationGame_ios
//
//  Created by Student10 on 18/06/2023.
//

import UIKit

class GameViewController: UIViewController {
    
    
    
    @IBOutlet weak var westSidePlayerName_Label: UILabel!
    @IBOutlet weak var eastSidePlayerName_Label: UILabel!
    @IBOutlet weak var westSidePlayerScore_Label: UILabel!
    @IBOutlet weak var eastSidePlayerScore_Label: UILabel!
    @IBOutlet weak var Timer_Label: UILabel!
    @IBOutlet weak var westSideCard_Image: UIImageView!
    @IBOutlet weak var eastSideCard_Image: UIImageView!
    
    let defaults = UserDefaults.standard
    var player_side : Int!
    let targetLat = 34.81754916832434
    
    var winner = "PC"
    
    var foldedCard = "folded_card"
    
    
    //let cards_clubs: [String:Int] = ["ace_of_clubs": 1, "2_of_clubs": 2, "3_of_clubs": 3, "4_of_clubs": 4, "5_of_clubs": 5, "6_of_clubs": 6, "7_of_clubs": 7, "8_of_clubs": 8, "9_of_clubs": 9, "10_of_clubs": 10, "jack_of_clubs": 11, "queen_of_clubs": 12, "king_of_clubs": 13]
    
    //let cards_diamonds: [String:Int] = ["ace_of_diamonds": 1, "2_of_diamonds": 2, "3_of_diamonds": 3, "4_of_diamonds": 4, "5_of_diamonds": 5, "6_of_diamonds": 6, "7_of_diamonds": 7, "8_of_diamonds": 8, "9_of_diamonds": 9, "10_of_diamonds": 10, "jack_of_diamonds": 11, "queen_of_diamonds": 12, "king_of_diamonds": 13]
        
    //let cards_hearts: [String:Int] = ["ace_of_heatrs": 1, "2_of_hearts": 2, "3_of_hearts": 3, "4_of_hearts": 4, "5_of_hearts": 5, "6_of_hearts": 6, "7_of_hearts": 7, "8_of_hearts": 8, "9_of_hearts": 9, "10_of_hearts": 10, "jack_of_hearts": 11, "queen_of_hearts": 12, "king_of_hearts": 13]
    
    //let cards_spades: [String:Int] = ["ace_of_spades": 1, "2_of_spades": 2, "3_of_spades": 3, "4_of_spades": 4, "5_of_spades": 5, "6_of_spades": 6, "7_of_spades": 7, "8_of_spades": 8, "9_of_spades": 9, "10_of_spades": 10, "jack_of_spades": 11, "queen_of_spades": 12, "king_of_spades": 13]
    
    
    let deck:[String:Int] = ["ace_of_clubs": 1, "2_of_clubs": 2, "3_of_clubs": 3, "4_of_clubs": 4, "5_of_clubs": 5, "6_of_clubs": 6, "7_of_clubs": 7, "8_of_clubs": 8, "9_of_clubs": 9, "10_of_clubs": 10, "jack_of_clubs": 11, "queen_of_clubs": 12, "king_of_clubs": 13, "ace_of_diamonds": 1, "2_of_diamonds": 2, "3_of_diamonds": 3, "4_of_diamonds": 4, "5_of_diamonds": 5, "6_of_diamonds": 6, "7_of_diamonds": 7, "8_of_diamonds": 8, "9_of_diamonds": 9, "10_of_diamonds": 10, "jack_of_diamonds": 11, "queen_of_diamonds": 12, "king_of_diamonds": 13, "ace_of_heatrs": 1, "2_of_hearts": 2, "3_of_hearts": 3, "4_of_hearts": 4, "5_of_hearts": 5, "6_of_hearts": 6, "7_of_hearts": 7, "8_of_hearts": 8, "9_of_hearts": 9, "10_of_hearts": 10, "jack_of_hearts": 11, "queen_of_hearts": 12, "king_of_hearts": 13, "ace_of_spades": 1, "2_of_spades": 2, "3_of_spades": 3, "4_of_spades": 4, "5_of_spades": 5, "6_of_spades": 6, "7_of_spades": 7, "8_of_spades": 8, "9_of_spades": 9, "10_of_spades": 10, "jack_of_spades": 11, "queen_of_spades": 12, "king_of_spades": 13]
    
    //var playerPoints = 0
    //var PcPoints = 0
    
    var westSidePoints = 0
    var eastSidePoints = 0
    
    struct Keys{
        static let key_winner = "key_winner"
        static let key_points = "key_points"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updatePlayersSide()
        updatePlayersLabels()
        startTheGame()


    }
    
    func startTheGame(){
        var gameDeck = deck
        
        for _ in 0...9 {
            eastSideCard_Image.image = UIImage(named: foldedCard)
            westSideCard_Image.image = UIImage(named: foldedCard)
            for i in 5...1{
                Timer_Label.text = String(i)
                sleep(1)
            }
            let westCard = (gameDeck.randomElement()?.key)!
            let westCardValue = gameDeck[westCard] ?? 0
            gameDeck.removeValue(forKey: westCard)
            let eastCard = (gameDeck.randomElement()?.key)!
            let eastCardValue = gameDeck[eastCard] ?? 0
            gameDeck.removeValue(forKey: eastCard)
            eastSideCard_Image.image = UIImage(named: eastCard)
            westSideCard_Image.image = UIImage(named: westCard)
            
            if westCardValue < eastCardValue {
                eastSidePoints += 1
            }
            if westCardValue > eastCardValue{
                westSidePoints += 1
            }
            
            // drow cards
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
        
    
    
       
    
    
    
    func updatePlayersSide(){
        if getSide() < targetLat{
            player_side = 0
        }else{
            player_side = 1
        }
            
    }
    
    func updatePlayersLabels(){
        if player_side == 0 {
            westSidePlayerName_Label.text = getName()
            eastSidePlayerName_Label.text = "PC"
        }else{
            westSidePlayerName_Label.text = "PC"
            eastSidePlayerName_Label.text = getName()
        }
        
        
    }
    
    func getName() -> String! {
        let name = defaults.string(forKey: ViewController.Keys.key_name)
        return name!
    }
    
    func getSide() -> Double{
        let side = defaults.double(forKey: ViewController.Keys.key_side)
        return side
    }
    
    func saveWinner(){
        defaults.set(winner, forKey: Keys.key_winner)
    }
    
    func savePoints(points :Int){
        defaults.set(points, forKey: Keys.key_points)
    }
    
    func endGame(){
        let gameOver_vc = storyboard?.instantiateViewController(identifier: "gameOver_vc") as! GameOverViewController
        present(gameOver_vc, animated: true)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}

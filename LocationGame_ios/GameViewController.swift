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
    var foldedCard = "folded_card"
    let deck:[String:Int] = ["ace_of_clubs": 1, "2_of_clubs": 2, "3_of_clubs": 3, "4_of_clubs": 4, "5_of_clubs": 5, "6_of_clubs": 6, "7_of_clubs": 7, "8_of_clubs": 8, "9_of_clubs": 9, "10_of_clubs": 10, "jack_of_clubs": 11, "queen_of_clubs": 12, "king_of_clubs": 13, "ace_of_diamonds": 1, "2_of_diamonds": 2, "3_of_diamonds": 3, "4_of_diamonds": 4, "5_of_diamonds": 5, "6_of_diamonds": 6, "7_of_diamonds": 7, "8_of_diamonds": 8, "9_of_diamonds": 9, "10_of_diamonds": 10, "jack_of_diamonds": 11, "queen_of_diamonds": 12, "king_of_diamonds": 13, "ace_of_hearts": 1, "2_of_hearts": 2, "3_of_hearts": 3, "4_of_hearts": 4, "5_of_hearts": 5, "6_of_hearts": 6, "7_of_hearts": 7, "8_of_hearts": 8, "9_of_hearts": 9, "10_of_hearts": 10, "jack_of_hearts": 11, "queen_of_hearts": 12, "king_of_hearts": 13, "ace_of_spades": 1, "2_of_spades": 2, "3_of_spades": 3, "4_of_spades": 4, "5_of_spades": 5, "6_of_spades": 6, "7_of_spades": 7, "8_of_spades": 8, "9_of_spades": 9, "10_of_spades": 10, "jack_of_spades": 11, "queen_of_spades": 12, "king_of_spades": 13]
    
    var winnerName = " "
    var winnerPoints = 0
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
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                self.startTheGame()
            }
        }
    }
    
    func startTheGame() {
        westSidePlayerScore_Label.text = "0"
        eastSidePlayerScore_Label.text = "0"
        playRound(round: 1, gameDeck: deck)
    }

    func playRound(round: Int, gameDeck: [String: Int]) {
        if round > 10 {
            // Game finished
            
            if westSidePoints > eastSidePoints{
                winnerName = westSidePlayerName_Label.text!
                winnerPoints = westSidePoints
            }else{
                winnerName = eastSidePlayerName_Label.text!
                winnerPoints = eastSidePoints
                
            }
            saveWinner()
            savePoints()
            print("winnerName: \(winnerName) winnerPoints: \(winnerPoints)")
            endGame()
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] timer in
            guard let self = self else { return }
            
            self.Timer_Label.text = "5"
            
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
                guard let self = self else { return }
                
                if let currentCount = Int(self.Timer_Label.text ?? "0"), currentCount > 0 {
                    self.Timer_Label.text = String(currentCount - 1)
                } else {
                    timer.invalidate()
                    self.Timer_Label.text = ""
                    
                    self.performCardComparison(gameDeck: gameDeck, round: round)
                }
            }
        }
    }

    func performCardComparison(gameDeck: [String: Int], round: Int) {
        self.eastSideCard_Image.image = UIImage(named: self.foldedCard)
        self.westSideCard_Image.image = UIImage(named: self.foldedCard)
        
        let westCard = (gameDeck.randomElement()?.key)!
        let westCardValue = gameDeck[westCard] ?? 0
        var updatedGameDeck = gameDeck
        updatedGameDeck.removeValue(forKey: westCard)
        
        let eastCard = (updatedGameDeck.randomElement()?.key)!
        let eastCardValue = updatedGameDeck[eastCard] ?? 0
        updatedGameDeck.removeValue(forKey: eastCard)
        
        self.eastSideCard_Image.image = UIImage(named: eastCard)
        self.westSideCard_Image.image = UIImage(named: westCard)
        
        if westCardValue < eastCardValue {
            self.eastSidePoints += 1
            self.eastSidePlayerScore_Label.text = String(self.eastSidePoints)
        } else if westCardValue > eastCardValue {
            self.westSidePoints += 1
            self.westSidePlayerScore_Label.text = String(self.westSidePoints)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return }
            
            let nextRound = round + 1
            self.playRound(round: nextRound, gameDeck: updatedGameDeck)
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
            defaults.set(winnerName, forKey: Keys.key_winner)
        }
        
        func savePoints(){
            defaults.set(winnerPoints, forKey: Keys.key_points)
        }
        
        func endGame(){
            let gameOver_vc = storyboard?.instantiateViewController(identifier: "gameOver_vc") as! GameOverViewController
            present(gameOver_vc, animated: true)
            
        }
        
    
}

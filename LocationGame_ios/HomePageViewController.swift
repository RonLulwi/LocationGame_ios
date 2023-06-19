//
//  ViewController.swift
//  LocationGame_ios
//
//  Created by Student10 on 18/06/2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var EnterNamePromp_LBL: UILabel!
    @IBOutlet weak var displayName_LBL: UILabel!
    @IBOutlet weak var submit_BTN: UIButton!
    @IBOutlet weak var start_BTN: UIButton!
    @IBOutlet weak var westSide_IMG: UIImageView!
    @IBOutlet weak var playerName_EDT: UITextField!
    @IBOutlet weak var eastSide_IMG: UIImageView!
    
    struct Keys{
        static let key_name = "key_name"
        static let key_side = "key_side"
    }
    
    var playerName = ""
    let defaults = UserDefaults.standard
    
    var locationManager = CLLocationManager()
    var currentLat = 34.628594
    var targetLat = 34.81754916832434
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let savedName = getName()
        if savedName == "Nun"{
            // de something
            start_BTN.isHidden = true
            displayName_LBL.isHidden = true
        }else{
            EnterNamePromp_LBL.isHidden = true
            submit_BTN.isHidden = true
            playerName_EDT.isHidden = true
            
            displayName_LBL.text = "Hi, " + savedName
            if currentLat < targetLat{
                eastSide_IMG.alpha = 30
            }else{
                westSide_IMG.alpha = 30
            }
        }
        saveSide()
    }
    
    @IBAction func onSubmitClicked(_ sender: UIButton) {
        if playerName_EDT.state.isEmpty{
            displayName_LBL.isHidden = false
            submit_BTN.isHidden = true
            EnterNamePromp_LBL.isHidden = true
            playerName_EDT.isHidden = true
            start_BTN.isHidden = false
            
            playerName = playerName_EDT.text!
            saveName()
            displayName_LBL.text = "Hi, " + playerName
            if currentLat < targetLat{
                eastSide_IMG.alpha = 30
            }else{
                westSide_IMG.alpha = 30
            }
            
        }
    }
    
    @IBAction func onStartClicked(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "game_vc") as! GameViewController
        present(vc, animated: true)
    }
    
    func saveName(){
        defaults.set(playerName, forKey: Keys.key_name)
    }
    
    func getName() -> String{
        let name = defaults.string(forKey: Keys.key_name) ?? "Nun"
        return name
    }
    
    func saveSide(){
        defaults.set(currentLat, forKey: Keys.key_side)
    }


}


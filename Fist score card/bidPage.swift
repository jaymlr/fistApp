//
//  bidPage.swift
//  Fist score card
//
//  Created by Jay Miller on 4/1/20.
//  Copyright © 2020 Jay Miller. All rights reserved.
//

import UIKit

class bidPage: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UIGestureRecognizerDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 13
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        
        return "\(pickerOptions[row])"
    }
    
    
    var playerCount = 0
    let pickerOptions = [0,1,2,3,4,5,6,7,8,9,10,11,12]
    let gameRound = ["","10","9","8","7","6","5","4","3","2","1","Flipper","Forehead","Flipper","1","2","3","4","5","6","7","8","9","10","Game Over"] //This is the current round of play
    var currentRound = 1
    
    var team1Score = 0 //This is team 2 total score
    var team2Score = 0 //This is team 2 total score
    
    
    @IBOutlet weak var pickerTeam1Bid: UIPickerView!
    @IBOutlet weak var pickerTeam2Bid: UIPickerView!
    
    
    @IBOutlet weak var pickerTeam1Tricks: UIPickerView!
    @IBOutlet weak var pickerTeam2Tricks: UIPickerView!
    
    
    @IBOutlet weak var constraintT1P5: NSLayoutConstraint!
    @IBOutlet weak var constraintT2P4: NSLayoutConstraint!
    @IBOutlet weak var constraintT2P3: NSLayoutConstraint!
    @IBOutlet weak var constraintT1P1: NSLayoutConstraint!
    @IBOutlet weak var constrainT1P4: NSLayoutConstraint!
    @IBOutlet weak var constraintT2P5: NSLayoutConstraint!
    
    
    @IBOutlet weak var team1Player1: UIButton!
    @IBOutlet weak var team2Player1: UIButton!
    @IBOutlet weak var team1Player2: UIButton!
    @IBOutlet weak var team2Player2: UIButton!
    @IBOutlet weak var team1Player3: UIButton!
    @IBOutlet weak var team2Player3: UIButton!
    @IBOutlet weak var team1Player4: UIButton!
    @IBOutlet weak var team2Player4: UIButton!
    @IBOutlet weak var team1Player5: UIButton!
    @IBOutlet weak var team2Player5: UIButton!
    
    @IBOutlet weak var gameRoundLabel: UILabel!
    @IBOutlet weak var flipperLabel: UILabel!
    @IBOutlet weak var nextRoundButton: UIButton!
    @IBOutlet weak var roundLabel: UILabel!
    
    @IBOutlet weak var team2ScoreLabel: UILabel!
    @IBOutlet weak var team1ScoreLabel: UILabel!
    @IBOutlet weak var playerRenameInstruction: UILabel!
    
    
    
    
    var team1Buttons : [UIButton]!
    var team2Buttons : [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerTeam1Bid.delegate = self
        pickerTeam2Bid.delegate = self
        pickerTeam1Tricks.delegate = self
        pickerTeam2Tricks.delegate = self
        pickerTeam1Bid.dataSource = self
        pickerTeam1Tricks.dataSource = self
        pickerTeam2Bid.dataSource = self
        pickerTeam2Tricks.dataSource = self
        team1Buttons = [team1Player1,team1Player2,team1Player3,team1Player4,team1Player5]
        team2Buttons = [team2Player1,team2Player2,team2Player3,team2Player4,team2Player5]
        initGame()
        
        

        // Do any additional setup after loading the view.
    }


    @IBAction func buttonTap(_ sender: Any) {
        let temp = sender as! UIButton
        selectButton(btn: temp)
    }
    
    
    func selectButton(btn: UIButton){
        
        if btn.tag == 0 {
            btn.setBackgroundImage(UIImage(named:"black-fist"), for: .normal)
            btn.tag = 1
        }else if btn.tag == 1 {
            btn.setBackgroundImage(UIImage(named:"red-fist"), for: .normal)
            btn.tag = 2
        }else {
            btn.setBackgroundImage(UIImage(systemName: "person.fill"), for: .normal)
            btn.tag = 0
        }
        
    }
    
    
    @IBAction func nextRound(_ sender: Any) {
        if currentRound == gameRound.count - 1 {
            self.navigationController?.popViewController(animated: true)
            return
        }

        tallyTeam1Score()
        tallyTeam2Score()
        resetButtons()
        resetTickers()
        updateRound()
        nextRoundButton.isEnabled = false
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
            self.nextRoundButton.isEnabled = true
        }
    }


    func tallyTeam1Score(){
    
        let team1Tricks = pickerTeam1Tricks.selectedRow(inComponent: 0)
        let team1Bids = pickerTeam1Bid.selectedRow(inComponent: 0)
        let team1Success = team1Tricks - team1Bids >= 0
        
        if team1Success {
            
            team1Score += 10 * team1Bids
            team1Score += team1Tricks - team1Bids
            
        }else{
            team1Score -= 10 * team1Bids
            
        }
        
        
        for btn in team1Buttons {
            if btn.tag == 1 {
                team1Score += 50
            }else if btn.tag == 2 {
                team1Score -= 50
            }
        }
            
            
        Timer.scheduledTimer(withTimeInterval: 0.005, repeats: true) { (t) in
            if self.team1ScoreLabel.text == "\(self.team1Score)"{
                t.invalidate()
                return
            }
            
            var tempScore = Int(self.team1ScoreLabel.text!) ?? 0
            if tempScore < self.team1Score{
                tempScore += 1
            
            }else{
                tempScore -= 1
            }
            self.team1ScoreLabel.text = "\(tempScore)"
        }


    }
    
    
    func tallyTeam2Score(){
        let team2Tricks = pickerTeam2Tricks.selectedRow(inComponent: 0)
        let team2Bids = pickerTeam2Bid.selectedRow(inComponent: 0)
        let team2Success = team2Tricks - team2Bids >= 0
        
        if team2Success {
            
            team2Score += 10 * team2Bids
            team2Score += team2Tricks - team2Bids
            
        }else{
            team2Score -= 10 * team2Bids
        }
        
        for btn in team2Buttons {
            if btn.tag == 1 {
                team2Score += 50
            }else if btn.tag == 2 {
                team2Score -= 50
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.005, repeats: true) { (t) in
            if self.team2ScoreLabel.text == "\(self.team2Score)"{
                t.invalidate()
                return
            }
            
            var tempScore = Int(self.team2ScoreLabel.text!) ?? 0
            if tempScore < self.team2Score{
                tempScore += 1
            
            }else{
                tempScore -= 1
            }
            self.team2ScoreLabel.text = "\(tempScore)"
        }
        
    }
    
    
    
    func resetTickers(){
        pickerTeam1Bid.selectRow(0, inComponent: 0, animated: true)
        pickerTeam2Bid.selectRow(0, inComponent: 0, animated: true)
        pickerTeam1Tricks.selectRow(0, inComponent: 0, animated: true)
        pickerTeam2Tricks.selectRow(0, inComponent: 0, animated: true)
        
    }
    
    func resetButtons(){
        for btn in team1Buttons{
            btn.tag = 0
            btn.setBackgroundImage(UIImage(systemName: "person.fill"), for: .normal )
        }
        
        for btn in team2Buttons{
            btn.tag = 0
            btn.setBackgroundImage(UIImage(systemName: "person.fill"), for: .normal )
        }
            
        }
        
    func updateRound(){
        currentRound += 1
        gameRoundLabel.text = gameRound[currentRound]
        if currentRound == gameRound.count - 2 {
            nextRoundButton.setTitle("Tally Score", for: .normal)
            
        }else if currentRound == gameRound.count - 1 {
            nextRoundButton.setTitle("New Game", for: .normal)
            roundLabel.isHidden = true
            
        }
        let isRoundInt = Int(gameRound[currentRound]) ?? 0
        flipperLabel.isHidden = isRoundInt == 0
    }
    
    func initGame(){
        currentRound = 1
        roundLabel.isHidden = false
        flipperLabel.isHidden = false
        gameRoundLabel.text = gameRound[currentRound]
        team1Score = 0
        team2Score = 0
        team1ScoreLabel.text = "\(team1Score)"
        team2ScoreLabel.text = "\(team2Score)"
        resetTickers()
        resetButtons()
        nextRoundButton.setTitle("Next Round", for: .normal)
        playerLayout()
        hidePlayerRename()
       

    
    }
    
    func playerLayout(){
        
        switch(playerCount){
        case 4:
            team1Player1.isHidden = true
            team2Player1.isHidden = true
            team1Player3.isHidden = true
            team2Player3.isHidden = true
            team1Player4.isHidden = true
            team2Player5.isHidden = true
            
            constraintT1P5.isActive = false
            constraintT2P4.isActive = false
            let constraintT1 = NSLayoutConstraint(item: team1Player5!, attribute: .centerY, relatedBy: .equal, toItem: team2Player2, attribute: .centerY, multiplier: 1, constant: 0
            )
            let constraintT2 = NSLayoutConstraint(item: team2Player4!, attribute: .centerY, relatedBy: .equal, toItem: team1Player2, attribute: .centerY, multiplier: 1, constant: 0
            )
            
            self.view.addConstraint(constraintT1)
            self.view.addConstraint(constraintT2)
            
            team1Player2.setTitle("Player 1", for: .normal)
            team2Player2.setTitle("Player 2", for: .normal)
            team1Player5.setTitle("Player 3", for: .normal)
            team2Player4.setTitle("Player 4", for: .normal)
            
            break
            
        case 6:
            team2Player1.isHidden = true
            team1Player3.isHidden = true
            team1Player4.isHidden = true
            team2Player5.isHidden = true
            
            constraintT1P1.isActive = false
            constraintT2P3.isActive = false
            
            let constraintT1 = NSLayoutConstraint(item: team1Player1!, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 0.25, constant: 0
            )
            let constraintT2 = NSLayoutConstraint(item: team2Player3!, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.75, constant: 0
            )
            
            self.view.addConstraint(constraintT1)
            self.view.addConstraint(constraintT2)
            
            team2Player3.setTitle("Player 1", for: .normal)
            team1Player2.setTitle("Player 2", for: .normal)
            team2Player2.setTitle("Player 3", for: .normal)
            team1Player1.setTitle("Player 4", for: .normal)
            team2Player4.setTitle("Player 5", for: .normal)
            team1Player5.setTitle("Player 6", for: .normal)
            
            
            
            break
            
        case 8:
            team1Player1.isHidden = true
            team2Player3.isHidden = true
            
            constraintT1P5.isActive = false
            constraintT2P4.isActive = false
            constrainT1P4.isActive = false
            constraintT2P5.isActive = false
            
            
            let constraintT1 = NSLayoutConstraint(item: team1Player5!, attribute: .centerY, relatedBy: .equal, toItem: team2Player2, attribute: .centerY, multiplier: 1, constant: 0
            )
            let constraintT2 = NSLayoutConstraint(item: team2Player4!, attribute: .centerY, relatedBy: .equal, toItem: team1Player2, attribute: .centerY, multiplier: 1, constant: 0
            )
            
            let constraintT3 = NSLayoutConstraint(item: team1Player4!, attribute: .centerY, relatedBy: .equal, toItem: team2Player1, attribute: .centerY, multiplier: 1, constant: 0
            )
            let constraintT4 = NSLayoutConstraint(item: team2Player5!, attribute: .centerY, relatedBy: .equal, toItem: team1Player3, attribute: .centerY, multiplier: 1, constant: 0
            )
            
            self.view.addConstraint(constraintT1)
            self.view.addConstraint(constraintT2)
            self.view.addConstraint(constraintT3)
            self.view.addConstraint(constraintT4)
            
            team2Player1.setTitle("Player 1", for: .normal)
            team1Player2.setTitle("Player 2", for: .normal)
            team2Player2.setTitle("Player 3", for: .normal)
            team1Player3.setTitle("Player 4", for: .normal)
            team2Player5.setTitle("Player 5", for: .normal)
            team1Player5.setTitle("Player 6", for: .normal)
            team2Player4.setTitle("Player 7", for: .normal)
            team1Player4.setTitle("Player 8", for: .normal)
            
            
            break
            
        default:

             break
            
        }
        
    }
    
    
    
    @IBAction func didLongPress(_ sender: Any) {
        let alert = UIAlertController(title: "Player Name", message: "Enter Your Player Name", preferredStyle: .alert)
        alert.addTextField { (textField) in
            
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            let text = alert.textFields![0].text
            
            let gesture = sender as! UILongPressGestureRecognizer
            let btn = gesture.view as! UIButton
            btn.setTitle(text, for: .normal)
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
   
    func hidePlayerRename(){
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (t) in
            UIView.animate(withDuration: 1, animations: {
                self.playerRenameInstruction.alpha = 0
            }) { (true) in
                self.playerRenameInstruction.isHidden = true
            }
            
            
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

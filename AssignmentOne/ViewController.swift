//
//  ViewController.swift
//  AssignmentOne
//
//  Created by Dyana George on 1/23/19.
//  Copyright © 2019 Dyana George. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //init vari
    var playerCredit: Int = 1000
    var winnings:Int = 0
    var jackpot:Int = 5000
    var turn:Int = 0
    var playerBet:Int = 1
    var winNumber:Int = 0
    var lossNumber:Int = 0
    var WinRatio:Int = 0
    
    var element1: Int = 0
    var element2: Int = 0
    var element3: Int = 0
    var element4: Int = 0
    var element5: Int = 0
    var element:[Int] = [0]
    
    var winSound: AVAudioPlayer!
    var spinnerMusic: AVAudioPlayer!
    
    @IBOutlet weak var credit: UILabel!
    
    @IBOutlet weak var betAmount: UILabel!
    
    @IBOutlet weak var winningAmount: UILabel!
    
    @IBOutlet weak var slotSpinner: UIPickerView!
    
    @IBAction func betMax(_ sender: UIButton) {
    }
    
    @IBAction func bet100(_ sender: UIButton) {
    }
    
    @IBAction func bet10(_ sender: UIButton) {
    }
    
    @IBAction func bet1(_ sender: UIButton) {
    }
    
    @IBAction func betPlusMinus(_ sender: UIStepper) {
    }
    
    
    //function for generator
    func numberGen() -> Int {
        let lower : UInt = 20
        let upper : UInt = 150
        let ranNum = arc4random_uniform(upper - lower) + lower
        return Int(ranNum)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //win Sound settings
        let url = Bundle.main.url(forResource: "Win", withExtension: "mp3")
        do{
            winSound = try AVAudioPlayer(contentsOf: url!)
            winSound.prepareToPlay()
        }
        catch let error as NSError{
            print(error.debugDescription)
        }
        
        //spinner Sound settings
        let url1 = Bundle.main.url(forResource: "Spin", withExtension: "mp3")
        do{
            spinnerMusic = try AVAudioPlayer(contentsOf: url1!)
            spinnerMusic.prepareToPlay()
        }
        catch let error as NSError{
            print(error.debugDescription)
        }
//        popupMessage.layer.cornerRadius = 5
        
    }
    
    //picker view
    
    // setting number of elements (images) in a Reel
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let myView = UIView(frame: CGRect(x:0,y:0, width:50, height:50))
        
        let myImageView = UIImageView(frame: CGRect(x:0,y:0,width:50,height:50))
        
        
        var banana:Int=0
        var grape:Int=1
        var cherry:Int=2
        var bar:Int=3
        var bell:Int=4
        var seven:Int=5
        var orange:Int=6
        
        for _ in 6 ... 200 {
            orange=orange+7
            
            switch row {
                
            case banana:
                
                myImageView.image = UIImage(named:"banana")
                
            case grape:
                
                myImageView.image = UIImage(named:"grapes")
                
            case cherry:
                
                myImageView.image = UIImage(named:"cherry")
                
            case bar:
                
                myImageView.image = UIImage(named:"bar")
                
            case bell:
                
                myImageView.image = UIImage(named:"bell")
                
            case seven:
                
                myImageView.image = UIImage(named:"seven")
                
            default :
                
                myImageView.image = UIImage(named:"orange")
                banana=banana+7
                grape=grape+7
                cherry=cherry+7
                bar=bar+7
                bell=bell+7
                seven=seven+7
                
            }
        }
        myView.addSubview(myImageView)
        
        return myView
    }
    
    //if you press the spin button
    @IBAction func spinBtn(_ sender: UIButton) {
        slotSpinner.selectRow((ranNum()) , inComponent: 0, animated: true)
        slotSpinner.selectRow((ranNum()) , inComponent: 1, animated: true)
        slotSpinner.selectRow((ranNum()) , inComponent: 2, animated: true)
        
        spinnerMusic.play()
        
        playerBet = Int(playerBet.text!)!
        
        if (playerCredit == 0) // if no money then show animation message to continue game or quit
        {
            animation()
            
            spinBtn.isUserInteractionEnabled = false
            
        }
        else if (playerBet > playerCredit) {
            popupMessageLabel.text = "You don't have enough Money to place that bet."
            animation()
            
        }
            
        else if (playerBet <= playerCredit) {
            
            determineWinnings(); // winnig criteria set for each spin
            turn += 1;
            showSpinResult(); //display result for each spin on screen
        }
    }
    
    //display result for each spin on screen
    func showSpinResult()
    {
        playerMoney.text = String(playerCredit)
        playerWins.text = String(winnings) + " Points"
    }
    
    
    //setting winnig criteria set for each spin
    func determineWinnings()
    {
        // get element id in each collumn set on reel
        element1 = slotSpinner.selectedRow(inComponent: 0)
        element2 = slotSpinner.selectedRow(inComponent: 1)
        element3 = slotSpinner.selectedRow(inComponent: 2)
        element4 = slotSpinner.selectedRow(inComponent: 3)
        element5 = slotSpinner.selectedRow(inComponent: 4)
        
        
        
        if(element1>6){
            element1 = element1%7
        }
        if(element2>6){
            element2 = element2%7
        }
        if(element3>6){
            element3 = element3%7
        }
        if(element4>6){
            element4 = element4%7
        }
        if(element5>6){
            element5 = element5%7
        }
        
        element = [ element1, element2, element3, element4, element5]
        
        winnings = 0
        
        //if all five elements match on spinner
        if (element1 == element2 && element2 == element3 && element3 == element4 && element4 == element5){
            if element1 == 0
            {
                print("banana")
                winnings = playerBet * 10
            }
            else if element1 == 1 {
                print("grapes")
                winnings = playerBet * 20
            }
            else if element1 == 2 {
                print("cherry")
                winnings = playerBet * 30
            }
            else if element1 == 3 {
                print("bar")
                winnings = playerBet * 40
            }
            else if element1 == 4 {
                print("bell")
                winnings = playerBet * 50
            }
            else if element1 == 5 {
                print("seven")
                winnings = playerBet * 75
            }
            else if element1 == 6 {
                print("orange")
                winnings = playerBet * 5
            }
            showWinMessage()
            winNumber += 1
            
        }else  if (element1 == element2 && element2 == element3 && element3 == element4 ){  //if four elements match on spinner
            if element1 == 0
            {
                print("banana")
                winnings = playerBet * 5
            }
            else if element1 == 1 {
                print("grapes")
                winnings = playerBet * 10
            }
            else if element1 == 2 {
                print("cherry")
                winnings = playerBet * 15
            }
            else if element1 == 3 {
                print("bar")
                winnings = playerBet * 20
            }
            else if element1 == 4 {
                print("bell")
                winnings = playerBet * 25
            }
            else if element1 == 5 {
                print("seven")
                winnings = playerBet * 35
            }
            else if element1 == 6 {
                print("orange")
                winnings = playerBet * 3
            }
            showWinMessage()
            winNumber += 1
            
        }else if (element2 == element3 && element3 == element4 && element4 == element5){  //if four elements match on reel
            if element2 == 0
            {
                print("banana")
                winnings = playerBet * 5
            }
            else if element2 == 1 {
                print("grapes")
                winnings = playerBet * 10
            }
            else if element2 == 2 {
                print("cherry")
                winnings = playerBet * 15
            }
            else if element2 == 3 {
                print("bar")
                winnings = playerBet * 20
            }
            else if element2 == 4 {
                print("bell")
                winnings = playerBet * 25
            }
            else if element2 == 5 {
                print("seven")
                winnings = playerBet * 35
            }
            else if element2 == 6 {
                print("orange")
                winnings = playerBet * 3
            }
            showWinMessage()
            winNumber += 1
            
        }
        else if (element1 == element2 && element1 == element3){  //if three elements match on spinner
            if element1 == 0
            {
                print("banana")
                winnings = playerBet * 3
            }
            else if element1 == 1 {
                print("grapes")
                winnings = playerBet * 5
            }
            else if element1 == 2 {
                print("cherry")
                winnings = playerBet * 7
            }
            else if element1 == 3 {
                print("bar")
                winnings = playerBet * 10
            }
            else if element1 == 4 {
                print("bell")
                winnings = playerBet * 12
            }
            else if element1 == 5 {
                print("seven")
                winnings = playerBet * 15
            }
            else if element1 == 6 {
                print("orange")
                winnings = playerBet * 2
            }
            showWinMessage()
            winNumber += 1
        }
        else if (element2 == element3 && element2 == element4){ //if three elements match on reel
            if element2 == 0
            {
                print("banana")
                winnings = playerBet * 3
            }
            else if element2 == 1 {
                print("grapes")
                winnings = playerBet * 5
            }
            else if element2 == 2 {
                print("cherry")
                winnings = playerBet * 7
            }
            else if element2 == 3 {
                print("bar")
                winnings = playerBet * 9
            }
            else if element2 == 4 {
                print("bell")
                winnings = playerBet * 10
            }
            else if element2 == 5 {
                print("seven")
                winnings = playerBet * 15
            }
            else if element2 == 6 {
                print("orange")
                winnings = playerBet * 2
            }
            showWinMessage()
            winNumber += 1
        }
            
        else if (element3 == element4 && element3 == element5 ){ //if three elements match on reel
            if element3 == 0
            {
                print("banana")
                winnings = playerBet * 3
            }
            else if element3 == 1 {
                print("grapes")
                winnings = playerBet * 5
            }
            else if element3 == 2 {
                print("cherry")
                winnings = playerBet * 7
            }
            else if element3 == 3 {
                print("bar")
                winnings = playerBet * 9
            }
            else if element3 == 4 {
                print("bell")
                winnings = playerBet * 10
            }
            else if element3 == 5 {
                print("seven")
                winnings = playerBet * 15
            }
            else if element3 == 6 {
                print("orange")
                winnings = playerBet * 2
            }
            showWinMessage()
            winNumber += 1
        }
        else
        {
            loosePoints()
            lossNumber += 1
        }
        
    }
    
    
    // Show win message on screen
    func showWinMessage() {
        winSound.play()
        playerCredit += winnings;
        animateWinPoint()
        checkJackPot()
    }
    
    // Loose points if no match on reel
    func loosePoints() {
        playerCredit -= playerBet;
    }
    
    // Animation view to display winnig message on screen
    func animateWinPoint()
    {
        self.view.addSubview(winPointsView)
        winPointsView.center = self.view.center
        winPointsView.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        winPointsView.alpha = 0
        winPointPopUp.text = String(winnings) + " Points"
        UIView.animate(withDuration: 3, animations: {
            self.winPointsView.alpha = 1
            
        }) { (success:Bool) in
            self.winPointsView.alpha = 0
            self.popupMessage.removeFromSuperview()
        }
    }
    
    // Check for jeckpot
    func checkJackPot() {
        /* compare two random values */
        let jackPotTry:Int = reandomNumber()
        let jackPotWin:Int = reandomNumber()
        if (jackPotTry == jackPotWin) {
            
            playerCredit += jackpot;
            winSound.play()
            playerJackpot.text = String(jackpot)
            jackpot = 1000;
        }
    }
    
    
    // Increase or decrease bet for user
    @IBAction func betStepper(_ sender: UIStepper) {
        
        let bet = Int(sender.value)
        player_bet.text = String(bet)
    }
    
    // Animation message when player money is finish
    func animation(){
        self.view.addSubview(popupMessage)
        popupMessage.center = self.view.center
        popupMessage.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        popupMessage.alpha = 0
        
        UIView.animate(withDuration: 0.4){
            self.popupMessage.alpha = 1
            self.popupMessage.transform = CGAffineTransform.identity
        }
    }
    



}


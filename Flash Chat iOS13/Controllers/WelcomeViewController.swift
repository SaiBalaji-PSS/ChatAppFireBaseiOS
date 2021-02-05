//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var Appnamelbl: CLTypingLabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        Appnamelbl.text = "⚡️FlashChat"
      
        
       /* let appname =
        
        var i = 0
        for letter in appname
        {
            
            Timer.scheduledTimer(withTimeInterval: 0.2*Double(i), repeats: false) { (T) in
                self.titleLabel.text?.append(letter)
            }
            
            
            i+=1
            
        }*/
        
        
       
    }
    
    @IBAction func RegisterBtnClicked(_ sender: UIButton) {
        
        performSegue(withIdentifier: "RegisterSegue", sender: self)
        
    }
    
    
    @IBAction func LoginBtnClicked(_ sender: UIButton) {
        
        performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    
}

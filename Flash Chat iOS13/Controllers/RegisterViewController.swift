//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
       
        
        if let email = emailTextfield.text , let password = passwordTextfield.text
        {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                
                if let e = error
                {
                    self.showpopup(message: e.localizedDescription)
                    print(e.localizedDescription)
                }
                
                else
                {
                    self.performSegue(withIdentifier: "ChatSegueOne", sender: self)
                }
             
            }
        }
        
        
        
    }
    
    func showpopup(message: String?)
    {
        if let m = message
        {
            let ac = UIAlertController(title: "Info", message: m, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(ac, animated: true, completion: nil)
        }
    }
    
}

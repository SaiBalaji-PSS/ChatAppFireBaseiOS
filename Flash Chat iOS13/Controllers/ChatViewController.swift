//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    let db = Firestore.firestore()
    
    
    @IBOutlet weak var chatoutsideview: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ChatTV: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadMessages()
        
        
        
        navigationItem.hidesBackButton = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(LogOutUser))
        
        
        
        
        
        
        
        ChatTV.register(UINib(nibName: "MessageCellTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        
        
        ChatTV.delegate = self
        ChatTV.dataSource = self
        
        
        

    }
    
    
    func loadMessages()
    {
       
       // db.collection("MESSAGES").order(by: "Time")// Sort the messages in latest order before retriving
        
        db.collection("MESSAGES").order(by: "Time")
            
            .addSnapshotListener { (querySnapshot, err) in
            
            self.messages.removeAll()
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
               
                if let snapshotDocument = querySnapshot?.documents
                {
                    for doc in snapshotDocument
                    {
                        if let senderofmessage = doc.data()["Sender"] as? String , let message = doc.data()["Body"] as? String
                        {
                            self.messages.append(Message(sender: senderofmessage, body: message))
                            
                            
                            DispatchQueue.main.async {
                                self.ChatTV.reloadData()
                            }
                          
                        }
                       
                    }
                }
                
                
            }
        }
        
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if  let messageBody = messageTextfield.text , let messagesender = Auth.auth().currentUser?.email
       {
            db.collection("MESSAGES").addDocument(data:
        ["Sender":messagesender,
         "Body":messageBody,
         "Time":Date().timeIntervalSince1970]) { (err) in
                
                if let e = err
                {
                    print(e.localizedDescription)
                }
                else
                {
                    print("Success")
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
                
            }
       }
        
        
    }
    
    @objc
    func LogOutUser()
    {
        let firebaseAuth = Auth.auth()
     do {
       try firebaseAuth.signOut()
        
        navigationController?.popToRootViewController(animated: true)
        
     } catch let signOutError as NSError {
       print ("Error signing out: %@", signOutError)
     }
       
    }
    

}

extension ChatViewController: UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? MessageCellTableViewCell
        {
            if !messages.isEmpty
            {
            cell.UpdateCell(Message: messages[indexPath.row].body)
                
                if messages[indexPath.row].sender == Auth.auth().currentUser?.email
                {
                    cell.senderimage.isHidden = true
                    cell.rightimageview.isHidden = false
                    cell.messagebubble.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                }
                else
                {
                    cell.senderimage.isHidden = false
                    cell.rightimageview.isHidden = true
                    cell.messagebubble.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                }
                
            }
            return cell
        }
        print("NO CELL")
        return UITableViewCell()
        
    }
    
    
}

//
//  MessageCellTableViewCell.swift
//  Flash Chat iOS13
//
//  Created by Sai Balaji on 04/02/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class MessageCellTableViewCell: UITableViewCell {

    
   
    @IBOutlet weak var messagebubble: UIView!
    
    @IBOutlet weak var rightimageview: UIImageView!
    @IBOutlet weak var senderimage: UIImageView!
    @IBOutlet weak var messagelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        messagebubble.layer.cornerRadius = messagelbl.frame.size.height / 5
        
        
        
    }
    
   

    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    func UpdateCell(Message: String)
    {
        self.messagelbl.text = Message
    }
    
}

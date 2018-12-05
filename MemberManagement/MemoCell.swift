//
//  MemoCell.swift
//  MemberManagement
//
//  Created by 503-17 on 29/11/2018.
//  Copyright © 2018 the. All rights reserved.
//

import UIKit

class MemoCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var regdate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

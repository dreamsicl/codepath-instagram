//
//  PostCell.swift
//  Insta
//
//  Created by Vanna Phong on 3/24/17.
//  Copyright © 2017 Vanna Phong. All rights reserved.
//

import UIKit
import Parse

class PostCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
//    var post: PFObject!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

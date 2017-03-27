//
//  PostCell.swift
//  Insta
//
//  Created by Vanna Phong on 3/24/17.
//  Copyright © 2017 Vanna Phong. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var post: PFObject? {
        didSet {
//            print("\(post)")
            let postImageFile = post?["media"] as? PFFile
            postImageFile?.getDataInBackground { (data: Data?, error: Error?) in
                if let data = data {
                    self.postImageView.image = UIImage(data: data)
                    self.postImageView.sizeToFit()
                }
            }

            // populate caption
            self.captionLabel.text = post?["caption"] as? String
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  PostCell.swift
//  Insta
//
//  Created by Vanna Phong on 3/24/17.
//  Copyright © 2017 Vanna Phong. All rights reserved.
//

import UIKit
import Parse
import FaveButton

class PostCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var faveButton: FaveButton!
    
    var likesCount: Int! {
        didSet {
            if likesCount == 1 {
                likeString = " LIKE"
            } else {
                likeString = " LIKES"
            }
        }
    }
    var likeString = ""
    
    var post: PFObject? {
        didSet {
//            print("\(post)")
            let postImageFile = post?["media"] as? PFFile
            postImageFile?.getDataInBackground { (data: Data?, error: Error?) in
                if let data = data {
                    self.postImageView.image = UIImage(data: data)
                    
                    // dynamic height
                    let aspectRatio = (self.postImageView.image?.size.height)! / (self.postImageView.image?.size.width)!
                    let screenSize = self.frame
                    let newFrame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.width * aspectRatio)
                    self.postImageView.image?.draw(in: newFrame)
                }
            }

            // populate caption
            self.captionLabel.text = post?["caption"] as? String
            
            // populate likes label
            self.likesCount = post?["likesCount"] as! Int
            self.likeCountLabel.text = String(self.likesCount) + self.likeString
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.faveButton.isSelected = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func onFaveButton(_ sender: Any) {
        
        Post.likePost(post: post!, liking: self.faveButton.isSelected)
        
        
        if self.faveButton.isSelected {
            self.likesCount = self.likesCount+1
        } else {
            self.likesCount = self.likesCount-1
        }
        
        self.post?["likesCount"] = self.likesCount
        
        self.likeCountLabel.text = String(self.likesCount) + self.likeString
        
    }

}

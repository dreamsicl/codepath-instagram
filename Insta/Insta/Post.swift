//
//  Post.swift
//  Insta
//
//  Created by Vanna Phong on 3/24/17.
//  Copyright © 2017 Vanna Phong. All rights reserved.
//

import UIKit
import Parse

class Post: PFObject {
    /**
     * Other methods
     */
    public static var progress: Float?
    /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image: image) // PFFile column type
        post["author"] = PFUser.current() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
    }
    
    /**
     Method to like a post.
     */
    class func likePost(post: PFObject, liking: Bool) {
        
        var currentLikes = post["likesCount"] as! Int
        if liking {
            currentLikes += 1
        } else {
            currentLikes -= 1
        }
        post["likesCount"] = currentLikes
        
        post.saveInBackground()
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}


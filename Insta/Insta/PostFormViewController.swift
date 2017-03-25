//
//  PostFormViewController.swift
//  Insta
//
//  Created by Vanna Phong on 3/24/17.
//  Copyright © 2017 Vanna Phong. All rights reserved.
//

import UIKit
import Parse

class PostFormViewController: UIViewController {

    var chosenImage: UIImage!
    @IBOutlet weak var chosenImageView: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        chosenImageView.image = chosenImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    @IBAction func onPostButton(_ sender: Any) {
        // post image to Parse
        Post.postUserImage(image: self.chosenImage, withCaption: self.captionField.text) { (success: Bool, error: Error?) in
            if (success) {
                print("posted successfully")
                self.performSegue(withIdentifier: "postedImageSegue", sender: self)
            } else {
                print("onPostButton(): postUserImage(): ERROR: \(error?.localizedDescription)")
            }
        }
        
        
        // return view to Feed
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

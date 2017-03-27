//
//  PostFormViewController.swift
//  Insta
//
//  Created by Vanna Phong on 3/24/17.
//  Copyright © 2017 Vanna Phong. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD


class PostFormViewController: UIViewController {

    var chosenImage: UIImage!
    @IBOutlet weak var chosenImageView: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        chosenImageView.image = chosenImage
        
        // tap image to pull up image picker again
//        let imgTap = UITapGestureRecognizer(target: self, action: "onImageTap")
//        chosenImageView.addGestureRecognizer(imgTap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Images
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        // Get the image captured by the UIImagePickerController and save to self.chosenImageView
//        if info[UIImagePickerControllerEditedImage] != nil {
//            // cropped image
//            self.chosenImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
//        } else {
//            // original image
//            self.chosenImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
//        }
//        
//        // Dismiss UIImagePickerController to go back to your original view controller
//        dismiss(animated: true, completion: nil)
//    }
//    
//    // tap image to show picker controller
//    func onImageTap() {
//        
//        // create picker controller
//        let vc = UIImagePickerController()
//        vc.delegate =
//        vc.allowsEditing = true
//        
//        // make sure camera is available to present
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            print("Camera is available 📸")
//            vc.sourceType = .camera
//        } else {
//            print("Camera 🚫 available so we will use photo library instead")
//            vc.sourceType = .photoLibrary
//        }
//        
//        // present picker controller
//        self.present(vc, animated: true, completion: nil)
//    }

    
    // image resize function
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
        // TODO: resize image for parse 10mb limit
        
        // show HUD
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Uploading..."
        
        // post image to Parse
        Post.postUserImage(image: self.chosenImage, withCaption: self.captionField.text) { (success: Bool, error: Error?) in
            
            // hide HUD on completion
            hud.hide(animated: true)
            
            if (success) {
                // return view to Feed
                print("posted successfully")
                self.performSegue(withIdentifier: "postedImageSegue", sender: self)
            } else {
                
                // unsuccessful upload, make alert for user
                let alertController = UIAlertController(title: "Error", message: "Could not upload post. Try again later.", preferredStyle: .alert)
                
                // add ok button to alert
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) in
                    // do nothing on completion
                })
                alertController.addAction(ok)
                
                // present alert
                self.present(alertController, animated: true, completion: { 
                    // do nothing on completion
                })
                print("onPostButton(): postUserImage(): ERROR: \(error?.localizedDescription)")
            }
            
            
        }
        
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

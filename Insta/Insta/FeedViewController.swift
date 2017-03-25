//
//  FeedViewController.swift
//  Insta
//
//  Created by Vanna Phong on 3/8/17.
//  Copyright © 2017 Vanna Phong. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    var chosenImage: UIImage?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            print("onLogoutButton().logOutInBackground(): ERROR: \(error?.localizedDescription)")
            self.performSegue(withIdentifier: "logoutSegue", sender: self)
        }
        
    }
    
    // MARK: Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
        
        return cell
    }
    
    
    // MARK: Image Picker/Post Button
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        self.chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        // let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        self.performSegue(withIdentifier: "postFormSegue", sender: self)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        
        // create picker controller
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        // make sure camera is available to present
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        // present picker controller
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "postFormSegue" {
            let destination = segue.destination as! PostFormViewController
            destination.chosenImage = chosenImage
            
        }
    }
    

}

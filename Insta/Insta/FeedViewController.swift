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
    var posts: [PFObject]?
    
    @IBOutlet weak var tableView: UITableView!
    let headerIdentifier = "TableSectionHeader"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // table view setup
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // header nib
        let nib = UINib(nibName: headerIdentifier, bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: headerIdentifier)

        // get any posts from Parse
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            print("querying parse...")
            if let posts = posts {
                self.posts = posts
                self.tableView.reloadData()
            } else {
                // handle error
                print("error: \(error?.localizedDescription)")
            }
        }
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        // individual section for each post
        
        if let posts = self.posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // one row per post
        
        if self.posts != nil {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
        
        cell.post = self.posts?[indexPath.section]
        
        return cell
    }
    
    // table header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as! TableSectionHeader
        let post = posts?[section]
        
        // populate username
        let user = post?["author"] as! PFUser
        header.usernameLabel.text = user.username
        
        // format timestamp
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        header.timestampLabel.text = formatter.string(from: (post?.createdAt)!).uppercased()
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TableSectionHeader.height
    }
    
    // MARK: Image Picker/Post Button
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Get the image captured by the UIImagePickerController and save to self.chosenImage
        if info[UIImagePickerControllerEditedImage] != nil {
            // cropped image
            self.chosenImage = info[UIImagePickerControllerEditedImage] as? UIImage
        } else {
            // original image
            self.chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        
        // segue to form
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

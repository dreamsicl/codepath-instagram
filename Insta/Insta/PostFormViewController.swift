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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

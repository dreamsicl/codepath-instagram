//
//  ViewController.swift
//  Insta
//
//  Created by Vanna Phong on 3/7/17.
//  Copyright © 2017 Vanna Phong. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            
            if user != nil {
                print("onSignIn(): SUCCESS")
                self.performSegue(withIdentifier: "loginSegue", sender: self)
            } else {
                print("onSignIn(): ERROR: \(error?.localizedDescription)")
            }
        }
    }

    @IBAction func onSignUp(_ sender: Any) {
        
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            
            if success {
                print("onSignUp(): SUCCESS")
                self.performSegue(withIdentifier: "loginSegue", sender: self)
            } else {
                print("onSignUp(): ERROR: \(error?.localizedDescription)")
            }
        }
    }
}


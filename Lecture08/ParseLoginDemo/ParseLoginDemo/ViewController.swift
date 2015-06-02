//
//  ViewController.swift
//  ParseLoginDemo
//
//  Created by Jonathan Engelsma on 6/2/15.
//  Copyright (c) 2015 Jonathan Engelsma. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ViewController: UIViewController,
    PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate
    
{

    @IBOutlet weak var loginMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if PFUser.currentUser() == nil {
            var loginCtrl = PFLogInViewController()
            loginCtrl.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.LogInButton | PFLogInFields.Facebook | PFLogInFields.SignUpButton
            loginCtrl.facebookPermissions = ["friends_about_me"]
            loginCtrl.delegate = self
            
            var signupCtrl = PFSignUpViewController()
            signupCtrl.delegate = self
            loginCtrl.signUpController = signupCtrl
            
            self.presentViewController(loginCtrl, animated: true, completion: nil)
        } else {
            self.loginMessage.text = PFUser.currentUser()?.username
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        if count(username) > 0 && count(password) > 0 {
            return true;
        }
        var alert = UIAlertView(title: "Missing login info", message: "Make sure you fill in the username and password!", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
        return false
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        self.loginMessage.text = user.username
        
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        println("login failed")
    }
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController) {
        println("login canceled by user")
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.loginMessage.text = user.username
    }
}


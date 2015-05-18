//
//  ViewController.swift
//  Lecture04.GreetingsApp
//
//  Created by Jonathan Engelsma on 5/14/15.
//  Copyright (c) 2015 Jonathan Engelsma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // our model
    var greeting: String = "Stony and Awkward Silence"
    
    @IBOutlet weak var greetingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.greetingLabel.text = self.greeting
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(sender: UIButton) {
        self.greeting = "A warm welcome to you sir."
        self.greetingLabel.text = self.greeting
    }

}


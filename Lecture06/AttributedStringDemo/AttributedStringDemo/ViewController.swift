//
//  ViewController.swift
//  AttributedStringDemo
//
//  Created by Jonathan Engelsma on 5/21/15.
//  Copyright (c) 2015 Jonathan Engelsma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var body: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func setColor(sender: UIButton) {
        self.body.textStorage.addAttribute(NSForegroundColorAttributeName, value: sender.backgroundColor!, range: self.body.selectedRange)
    }
    

    @IBAction func underlineOn(sender: AnyObject) {
        self.body.textStorage.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleDouble.rawValue, range: self.body.selectedRange)
        
    }
    
    @IBAction func underlineOff(sender: AnyObject) {
                self.body.textStorage.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleNone.rawValue, range: self.body.selectedRange)
    }
    
}


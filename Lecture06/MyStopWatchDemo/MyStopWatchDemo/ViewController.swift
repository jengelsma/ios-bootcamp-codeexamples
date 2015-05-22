//
//  ViewController.swift
//  MyStopWatchDemo
//
//  Created by Jonathan Engelsma on 5/19/15.
//  Copyright (c) 2015 Jonathan Engelsma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var modeButton: UIButton!
    @IBOutlet weak var displayLabel: UILabel!
    
    
    var myModel: MyModel = MyModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.myModel.stopWatchTimer = NSTimer(timeInterval: 1.0/10.0, target:self,
            selector: "updateTimer", userInfo: nil,  repeats: true)
        NSRunLoop.currentRunLoop().addTimer(self.myModel.stopWatchTimer, forMode: NSRunLoopCommonModes)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        if self.modeButton == nil || self.modeButton?.titleLabel!.text == "Day" {
            return UIStatusBarStyle.Default
        } else {
            return UIStatusBarStyle.LightContent
        }
    }

    func updateTimer()
    {
        if(self.myModel.timing) {
            var currentDate: NSDate = NSDate()
            var timeInterval: NSTimeInterval = currentDate.timeIntervalSinceDate(self.myModel.startTime)
            var timerDate = NSDate(timeIntervalSince1970: timeInterval)
            var dateFormatter = NSDateFormatter()
            dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT")
            dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm:ss:SSS")
            var timeString:String = dateFormatter.stringFromDate(timerDate)
            self.displayLabel.text = timeString
        }
    }

    @IBAction func clearTimer(sender: UIButton) {
        self.displayLabel.text = "00:00:00:000"
    }
    
    @IBAction func toggleNightMode(sender: UIButton) {
        if self.modeButton.titleLabel!.text == "Night" {
            self.modeButton.setTitle("Day", forState: UIControlState.Normal)
            self.view.backgroundColor = UIColor.blackColor()
            self.displayLabel.textColor = UIColor.whiteColor()
        } else {
            self.modeButton.setTitle("Night", forState: UIControlState.Normal)
            self.view.backgroundColor = UIColor.whiteColor()
            self.displayLabel.textColor = UIColor.blackColor()
        }
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    @IBAction func startTimer(sender: UIButton) {
        if self.myModel.timing {
            self.myModel.pauseTime = NSDate()
            self.myModel.timing = false
            self.startButton.setTitle("Start", forState: UIControlState.Normal)
            self.clearButton.enabled = true
        } else {
            self.myModel.timing = true
            if self.displayLabel.text == "00:00:00.000" {
                self.myModel.startTime = NSDate()
            } else {
                var currentDate = NSDate()
                var timeInterval: NSTimeInterval = currentDate.timeIntervalSinceDate(self.myModel.pauseTime)
                self.myModel.startTime = self.myModel.startTime.dateByAddingTimeInterval(timeInterval)
            }
            self.startButton.setTitle("Pause", forState:UIControlState.Normal)
            self.clearButton.enabled = false
        }
    }
}


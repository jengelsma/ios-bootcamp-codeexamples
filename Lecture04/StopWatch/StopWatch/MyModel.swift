//
//  MyModel.swift
//  StopWatch
//
//  Created by Jonathan Engelsma on 5/14/15.
//  Copyright (c) 2015 Jonathan Engelsma. All rights reserved.
//

import Foundation

struct MyModel {
    var startTime: NSDate
    var pauseTime: NSDate
    var nightMode: Bool = false
    var timing: Bool = false
    var stopWatchTimer: NSTimer
    
    init(){
        startTime = NSDate()
        pauseTime = NSDate()
        stopWatchTimer = NSTimer()
    }
}
//
//  MyGlobalDefs.swift
//  LifeCycleDemo
//
//  Created by Jonathan Engelsma on 5/14/15.
//  Copyright (c) 2015 Jonathan Engelsma. All rights reserved.
//

import Foundation

func pretty_function(msg: String, file:String = __FILE__, function:String = __FUNCTION__, line:Int = __LINE__){
    println("file:\(file.lastPathComponent) function:\(function) line:\(line) [\(msg)]")
}

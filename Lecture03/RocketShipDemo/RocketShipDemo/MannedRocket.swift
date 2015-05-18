//
//  MannedRocket.swift
//  RocketShipDemo
//
//  Created by Jonathan Engelsma on 5/18/15.
//  Copyright (c) 2015 Jonathan Engelsma. All rights reserved.
//

import Foundation

class MannedRocket : Rocket {
    var astronaut1: String
    var astronaut2: String?
    
    convenience init(fuel:Int, astronaut1: String)
    {
        self.init(fuel: fuel, astronaut1: astronaut1, astronaut2: nil)
    }
    
    // designated initializer
    init(fuel: Int, astronaut1: String, astronaut2: String?) {
        self.astronaut1 = astronaut1
        self.astronaut2 = astronaut2
        super.init(fuel: fuel)
    }
    
    override func programmableBlastOff(instructions: (Int) -> Void) {
        instructions(self.fuelTank)
        println(self.astronaut1 + " is now in space!")
        if(self.astronaut2 != nil) {
            println(self.astronaut2! + " is now in space!")
        }
        
    }
}
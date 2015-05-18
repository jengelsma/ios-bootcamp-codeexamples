//
//  Rocket.swift
//  RocketShipDemo
//
//  Created by Jonathan Engelsma on 5/18/15.
//  Copyright (c) 2015 Jonathan Engelsma. All rights reserved.
//

import Foundation

protocol SelfDestructableAirShip {
    func selfDestruct() -> Void
}

class Rocket: SelfDestructableAirShip {
    
    var fuelTank: Int
    
    init(fuel: Int) {
        self.fuelTank = fuel
    }
    
    func blastOff() {
        for var i=10; i>0; i-- {
            println(i)
        }
        println(">>>> BLAST off!! <<<<<")
    }
    
    func programmableBlastOff(instructions: (Int) -> Void) {
        instructions(self.fuelTank)
    }
    
    func selfDestruct() -> Void {
        println("KaPoW!!! rocket has been nuked!")
    }
    
}
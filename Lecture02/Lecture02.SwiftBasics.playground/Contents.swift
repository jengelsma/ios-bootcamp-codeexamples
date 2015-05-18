//: Playground - noun: a place where people can play

import UIKit

// obligatory hello world

println("Hello World")

// constants

let implicitConst = 25
let explicitConst: String = "hello"

let explicitDouble: Double
explicitDouble = 3.14

// vars

var aNiceMessage = "bye"
var myCounter: Int = 1
++myCounter
aNiceMessage = "My counter is "
let msg = aNiceMessage + String(myCounter)

// Strings

var aString = "favorites: "
let g,r,b: String
g="green"; r="red"; b="blue"
aString += g + ", " + r + ", " + b

// concat and interpolation

var language = "Swift"
var productivity = 10
var output = "My favorite language " + language + " makes me \(productivity)X more productive"

// comparing strings, and checking prefix/suffix.

if language == "Swift" {
    println("hurrah")
} else {
    println("too bad!")
}

if output.hasPrefix("My favorite") {
    println("yup")
}

if(output.hasSuffix("10X more productive")) {
    println("you bet!")
}


// arrays

var shoppingList: [String] = ["milk", "eggs", "bread"]
println("There are \(shoppingList.count) items in the list")
println("The last item is " + shoppingList[2])
shoppingList.append("chips")
shoppingList += ["dogfood","catfood"]


// iterating through an array in Swift!
for item in shoppingList {
    println(item)
}

for (index, value) in enumerate(shoppingList) {
    println("Item \(index + 1): \(value)")
}

// dictionaries

var languageLikes: Dictionary<String,Int> = ["Java":10,"Objective-C":2,"Swift":12,"VB": 0]
var javaLikes = languageLikes["Java"]
languageLikes["Ruby"] = 15
if(languageLikes["Swift"] > languageLikes["Ruby"]) {
    println("Swift wins!")
} else {
    println("Ruby wins!")
}

for(language, likes) in languageLikes {
    println("\(language): \(likes)")
}

// iterate over a range!
for index in 1...5 {
    println("\(index) times 5 is \(index * 5)")
}

// C-style for loops!
for var index = 1; index <= 5; ++index {
    println("\(index) times 5 is \(index * 5)")
}

// if you don't need the index values, use undercore instead of var name
let base = 3, power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
println("\(base) to the power of \(power) is \(answer)")

// while
var n = 5, cnt = 1
do {
    println("\(cnt) times 5 is \(cnt * 5)")
    cnt++;
} while(cnt <= 5)

// do-while
cnt = 1
do {
    println("\(cnt) times 5 is \(cnt * 5)")
    cnt++;
} while(cnt <= 5)


var temp: Int = 50
if temp <= 32 {
    println("It is freezing out here")
} else if temp > 32 && temp <= 80 {
    println("How temperate it is here!")
} else if temp > 80 && temp <= 100 {
    println("It is a sweat shop here!")
} else {
    println("The thermometer is broken!")
}

var t: Int = 32
switch t {
case 0...32:
    println("It is freezing out here")
case 33...80:
    println("How temperate it is here!")
case 81...100:
    println("It is a sweat shop here!")
default:
    println("The thermometer is broken!")
}

// define a function
func stateYoMission(actionVerb: String) -> String {
    let mission = "I will " + actionVerb + " the dog!"
    return mission
}
// invoke the function
println(stateYoMission("walk"))

// multiple parameters
func stateYoMission(actionVerb: String, noun:String) -> String {
    let mission = "I will " + actionVerb + " the " + noun + "!"
    return mission
}
//invoke
println(stateYoMission("walk","cat"))


// function with multiple ret vals
func findTheCenter(x1:Int, y1:Int, x2:Int, y2:Int) -> (x: Int, y:Int)
{
    return ((x2 - x1) / 2, (y2 - y1) / 2)
}
println(findTheCenter(0,0,10,10))


func join(s1: String, s2: String, joiner: String) ->String
{
    return s1 + joiner + s2
}
join("hello","world",", ")


// now let's add external parameter names!
func join(string s1: String, toString s2: String, withJoiner joiner: String) ->String
{
    return s1 + joiner + s2
}
// now ain't this so very purty?
join(string: "hello", toString: "world", withJoiner: ", ")


// now checkout this even purtier shorthand!
func joinv2(#string: String, #toString: String, #withJoiner: String) ->String
{
    return string + withJoiner + toString
}
// now ain't this so very purty?
joinv2(string: "hello", toString: "world", withJoiner: ", ")



// function types

func addTwoInts(a: Int, b: Int) -> Int
{
    return a + b
}

func multiplyTwoInts(a: Int, b: Int) -> Int
{
    return a * b
}

// call a function referred to by a variable of function type
var mathFunction: (Int, Int) -> Int = addTwoInts
println("Results: \(mathFunction(4,6))")

// call another!
mathFunction = multiplyTwoInts
println("Results: \(mathFunction(4,6))")


// passing function as parameters
func printMathResults(mathFunction: (Int, Int) -> Int, a: Int, b: Int) {
    println("Result: \(mathFunction(a,b))")
}
printMathResults(addTwoInts, 3, 5)

// returning function from function
func stepForward(input: Int) -> Int {
    return input + 1
}
func stepBackward(input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    return backwards ? stepBackward : stepForward
}

var curVal = 3;
let moveNearToZero = chooseStepFunction(true)
curVal = moveNearToZero(curVal)

// nested functions:
func chooseStepFunctionv2(backwards: Bool) -> (Int) -> Int {
    func stepForwardv2(input: Int) -> Int {
        return input + 1
    }
    func stepBackwardv2(input: Int) -> Int {
        return input - 1
    }
    return backwards ? stepBackwardv2 : stepForwardv2
}
curVal = 3;
let moveAwayFromZero = chooseStepFunction(false)
curVal = moveAwayFromZero(curVal)


// closure examples
let students = ["joe", "camila", "ryan", "roland"]
students.map({
    (student: String) -> String in
    "\(student) is getting swifter!"
})

// type inferencing - swift knows it is a string array, so we can write like this:
let studentMsgs = students.map({student in "\(student) is very swift!"})

// shorthand arguments
let studentStatus = students.map({$0 + " will definitely pass"})


// trailing closures - can put closure outside the parens
let studentBadNews = students.map() {$0 + " will definitely fail"}

// trailing closures - if no params, other than closure, parens not needed!
let studentUtopia = students.map {$0 + " lands a paying job!"}



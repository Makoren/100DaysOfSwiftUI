let driving = {
    print("I'm driving in my car!")
}
driving()

let driving2 = { (place: String) in
    print("I'm going to \(place) in my car!")
}
driving2("London")

let driving3 = { (place: String) -> String in
    return "I'm going to \(place) in my car!"
}
print(driving3("London"))

let returnOnlyClosure = { () -> Bool in
    print("Paying an anonymous person.")
    return true
}

func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I've arrived!")
}
travel(action: driving)

travel {
    print("I'm driving!")
}

func doThing(name: String, thing: () -> Void) {
    print("Time to do \(name)")
    thing()
}
doThing(name: "thing") {
    print("Doing thing")
}

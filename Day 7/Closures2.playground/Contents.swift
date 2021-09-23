func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}
travel { (place: String) in
    print("I'm going to \(place) in my car.")
}

func travelReturn(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}
travelReturn { (place: String) -> String in
    return "I'm going to \(place) in my car."
}

travelReturn { place -> String in
    return "I'm going to \(place) in my car."
}

travelReturn { place in
    return "I'm going to \(place) in my car."
}

travelReturn { place in
    "I'm going to \(place) in my car."
}

travelReturn {
    "I'm going to \($0) in my car."
}

// advanced
func travelMultiple(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("London", 60)
    print(description)
    print("I arrived!")
}
travelMultiple {
    "I'm going to \($0) at \($1) miles per hour."
}

func travelReturnClosure() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}
let result = travelReturnClosure()
result("London")
travelReturnClosure()("London")

func travelCapture() -> (String) -> Void {
    var counter = 1
    return {
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}
let captured = travelCapture()
captured("London")
captured("Paris")
captured("Tokyo")

var dict = [String: Int]()
dict["yeet"] = 0
dict["whoa", default: 0]

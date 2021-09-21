func printHelp() {
    let message = """
    Welcome to MyApp!
    
    Run this app inside a directory of images and
    MyApp will resize them all into thumbnails.
    """
    print(message)
}

printHelp()

// parameters and return values
func square(number: Int) -> Int {
     return number * number
}
square(number: 8)

// parameter labels
func sayHello(to name: String) {
    print("Hello, \(name)!")
}
sayHello(to: "Taylor")

func greet(_ person: String, nicely: Bool = true) {
    if nicely {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}
greet("Taylor")
greet("Taylor", nicely: false)

// varaidic functions
func square(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}
square(numbers: 1, 2, 3, 4, 5)

// throwing functions
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    return true
}

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

// inout
func doubleInPlace(number: inout Int) {
    number *= 2
}
var myNum = 10
doubleInPlace(number: &myNum)

// you can use a varaidic parameter alongside other parameters as long as it's at the end
func repeatStrings(amount: Int, strings: String...) {
    for _ in 1...amount {
        print("Repeat...")
        for string in strings {
            print(string)
        }
    }
}
repeatStrings(amount: 3, strings: "one", "two", "three")

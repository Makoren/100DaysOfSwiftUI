// variables and constants, data types
var age: Int
let name: String = "Luke"
age = 25

// operators, string interpolation
age += 1
let lastName = "Lazzaro"
let fullName = name + " " + lastName
let fullName2 = "\(name) \(lastName)"

// arrays, loops
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
var evenNumbers = [Int]()
for number in numbers {
    if number % 2 == 0 {
        evenNumbers.append(number)
    }
}
evenNumbers

// dictionaries
var city = [
    "name": "Melbourne",
    "population": "5000000"
]
city["name"]
city["weather", default: "raining"]

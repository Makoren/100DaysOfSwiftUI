// arrays, can change size, only one type
let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo]

beatles[1]

// sets, unordered and can't have duplicates
let colours = Set(["red", "green", "blue"])
let colours2 = Set(["red", "green", "blue", "red", "blue"])

// tuples, fixed in size, can't change the names inside once created, can mix data types
var name = (first: "Taylor", last: "Swift")
name.0
name.first
name.first = "Justin"

// dictionaries, unordered and use keys for value retrieval, result can be nil
let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]
heights["Taylor Swift"]
heights["no one"]

// avoid nil by doing this
heights["no one", default: 0]

let what = [0: "thing"]
what[0]

// empty collections
var teams = [String: String]()
teams["Paul"] = "Red"

var results = [Int]()

var words = Set<String>()
var numbers = Set<Int>()

var scores = Dictionary<String, Int>()
var results2 = Array<Int>()

// enumerations, a custom type with fixed values
enum Result {
    case success
    case failure
}
let result = Result.failure
let result2: Result = .failure  // :)

// enums with associated values, allows you to add extra detail to an enum value
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}
let talking = Activity.talking(topic: "football")

// enums with raw values, lets use define a specific raw value for each enum value
// this is useful when sending enum values over the internet for example
enum Planet: Int {
    case mercury
    case venus = 10
    case earth
    case mars
}
Planet.mercury.rawValue
Planet.earth.rawValue

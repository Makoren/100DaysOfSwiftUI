var firstScore = 12
var secondScore = 4

let total = firstScore + secondScore
let difference = firstScore - secondScore
let product = firstScore * secondScore
let divided = firstScore / secondScore
let remainder = 13 % secondScore

// you can't add ints and doubles together because of issues like this
let value: Double = 90000000000000001
let intValue: Int = 90000000000000001

let fakers = "Fakers gonna "
let action = fakers + "fake"

let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf

// you can't add two different types together

var score = 95
score -= 5

var quote = "The rain in spain falls mainly on the "
quote += "Spaniards"

firstScore = 6
secondScore = 4

firstScore == secondScore
firstScore != secondScore

firstScore < secondScore
firstScore >= secondScore

// this checks alphabetical order
"Taylor" <= "Swift"

let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 2 {
    print("Aces - lucky!")
} else if firstCard + secondCard == 21 {
    print("Blackjack!")
} else {
    print("Regular cards")
}

let age1 = 12
let age2 = 21

if age1 > 18 || age2 > 18 {
    print("At least one is over 18")
}

firstCard == secondCard ? "Cards are the same" : "Cards are different"

let weather = "sunny"

switch weather {
case "rain":
    print("Bring an umbrella")
case "sunny":
    print("Wear sunscreen")
    fallthrough // this executes both the code in the case, and the code in the case below it
default:
    print("Enjoy your day!")
}

let score2 = 85

switch score {
case 0..<50:
    print("You failed badly")
case 50..<85:
    print("You did OK")
default:
    print("You did great!")
}

let names = ["Piper", "Alex", "Suzanne", "Gloria"]
print(names[1...])

let passingGrade = 70...100

import Darwin
import Foundation

enum WeatherType {
    case sun
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}

func favoriteAlbum(_ name: String, year: Int) -> String {
    return "My favorite is \(name), which was released in \(year)."
}
let message = favoriteAlbum("Getting Better", year: 2021)
print(message)

func getHaterStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil
    default:
        return "Hate"
    }
}

let status = getHaterStatus(weather: .sun)?.uppercased()
print(status ?? "everything is fine")

func weatherLikingStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil
    case .wind(let speed) where speed < 10:
        return "meh"
    case .cloud, .wind:
        return "dislike"
    case .rain, .snow:
        return "hate"
    }
}
weatherLikingStatus(weather: .wind(speed: 5))

struct Person {
    var clothes: String
    var shoes: String
}
let taylor = Person(clothes: "T-shirts", shoes: "sneakers")
let other = Person(clothes: "short skirts", shoes: "high heels")
print(taylor.clothes)
print(other.shoes)

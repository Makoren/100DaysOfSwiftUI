class Person {
    private var clothes = "shirt" {
        willSet {
            print("Changing from \(clothes) to \(newValue)")
        }
        
        didSet {
            print("Changed from \(oldValue) to \(clothes)")
        }
    }
    
    var age = 25
    var ageInDogYears: Int {
        get { age * 7 }
    }
    
    static let morals = "bad"
    
    init() {}
    
    func setClothes(_ newClothes: String) {
        clothes = newClothes
    }
}
var person = Person()
person.setClothes("jacket")
print(person.ageInDogYears)
print(Person.morals)

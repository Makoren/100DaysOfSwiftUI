struct User {
    var username: String
    
    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}
var user = User()
user.username = "Makoren"

struct Person {
    var name: String
    lazy var familyTree = FamilyTree()
    
    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}

struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}
var ed = Person(name: "Ed")
ed.familyTree

struct Student {
    static var classSize = 0
    var name: String
    
    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}
print(Student.classSize)

struct Person2 {
    private var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func identify() -> String {
        return "My social security number is \(id)"
    }
}
let edd = Person2(id: "12345")
edd.identify()

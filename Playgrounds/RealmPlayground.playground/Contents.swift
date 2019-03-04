import UIKit
import XCPlayground
import PlaygroundSupport
import RealmSwift

PlaygroundPage.current.needsIndefiniteExecution = true

// Why `@objc`?
// ============
// `Object` is coming from
// `@objc(RealmSwiftObject) open class Object : RLMObjectBase, ThreadConfined, RealmCollectionValue`
// and `RLMObjectBase` --> `NSObject`
// Need to use Objective-C runtime to observe changes made on properties. var properties are only available with Obj-C run time?



// Why `dynamic`?
// ==============
// Changes made on property values are to be observed from `Realm` core to save back in DB.
// Needs to support dynamic access with KVO



class Dog: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}

class Person: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var picture: Data? = nil
    let dogs = List<Dog>()
}

// Let's create a dog
let myDog = Dog()
myDog.name = "Rex"
myDog.age = 1

print(myDog.name)



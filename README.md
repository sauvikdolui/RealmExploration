# RealmExploration
Sample Swift 4.2 project with RealmSwift 3.13.1

### This is a sample demo project to explore RealmSwift

### How to play with RealmSwift on Swift Playground?

1. Create a Single View Application on Xcode.
2. Install RealmSwift using cocoapods. Podfile Example
    ```ruby
    # Uncomment the next line to define a global platform for your project
    # platform :ios, '9.0'

    target 'RealmExploration' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
  
    # Pods for RealmExploration 
    pod 'RealmSwift'
    
    end
    ```
3. Create new Playground (Alt + Shift + Cmd + N) to create a new Playgorund under your workspace.
      // TODO: Add Screenshot here
4. On play ground paste the following sample code [RealmSwift Guide](https://realm.io/docs/swift/latest/).
    ```swift
    import XCPlayground
    import PlaygroundSupport
    import RealmSwift

    PlaygroundPage.current.needsIndefiniteExecution = true


    // Define your models like regular Swift classes
    class Dog: Object {
        @objc dynamic var name = ""
        @objc dynamic var age = 0
    }
    class Person: Object {
        @objc dynamic var name = ""
        @objc dynamic var picture: Data? = nil // optionals supported
        let dogs = List<Dog>()
    }

    // Use them like regular Swift objects
    let myDog = Dog()
    myDog.name = "Rex"
    myDog.age = 1
    print("name of dog: \(myDog.name)")

    // Get the default Realm
    let realm = try! Realm()

    // Query Realm for all dogs less than 2 years old
    let puppies = realm.objects(Dog.self).filter("age < 2")
    puppies.count // => 0 because no dogs have been added to the Realm yet

    // Persist your data easily
    try! realm.write {
        realm.add(myDog)
    }

    // Queries are updated in realtime
    puppies.count // => 1

    // Query and update from any thread
    DispatchQueue(label: "background").async {
        autoreleasepool {
            let realm = try! Realm()
            let theDog = realm.objects(Dog.self).filter("age == 1").first
            try! realm.write {
                theDog!.age = 3
            }
        }
    }
    ```
    // TODO: Add Screenshot here

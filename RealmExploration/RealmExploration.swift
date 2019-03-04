//
//  RealmExploration.swift
//  RealmExploration
//
//  Created by Sauvik Dolui on 04/03/19.
//  Copyright © 2019 Sauvik Dolui. All rights reserved.
//

import Foundation
import RealmSwift


class Dog: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}

class Person: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var picture: Data? = nil
    let dogs = List<Dog>()
}

func realm_exploration() {

    
    // Let's create a dog
    let myDog = Dog()
    myDog.name = "Rex"
    myDog.age = 2
    
    print(myDog.name)
    
    // Executing a query
    do {
        let realm = try Realm()
        let puppies = realm.objects(Dog.self).filter("age <= 3")
        // Count => 0 as we have not saved any Dog yet
        print("Puppies Count Before Write = \(puppies.count)")
        
        // Let's try to save the myDog into currnt realm instance
//        try realm.write {
//            realm.add(myDog)
//        }
        print("Puppies Count After Write = \(puppies.count)")
        realm_execution_separate_thread(dog: puppies.first!)
        
    } catch let error as NSError {
        print("Realm Error: \(error.localizedDescription)")
    }
    
    
    
    
    
    
}

let rmlQueue = DispatchQueue(label: "RealmQueue", qos: .background)
func realm_execution_separate_thread(dog: Dog) {
    rmlQueue.async {
        do {
            let realm = try Realm()
            let puppies = realm.objects(Dog.self).filter("age <= 10")
            // Count => 0 as we have not saved any Dog yet
            print("Puppies Count rlmQueue Before Write = \(puppies.count)")
            
            // Let's try to save the myDog into currnt realm instance
            try realm.write {
                dog.age = 5
                realm.add(dog)
            }
            print("Puppies Count rlmQueue After Write = \(puppies.count)")
            
        } catch let error as NSError {
            print("Realm Error: \(error.localizedDescription)")
        }
    }
}

func background_app_refresh_support(){
    // Less protection to avoid open() error, operation not permitted exception
    
    let realm = try! Realm()
    
    // Path to DB files container
    let folderPath = realm.configuration.fileURL!.deletingPathExtension().path
    
    try! FileManager.default.setAttributes([.protectionKey : FileProtectionType.completeUntilFirstUserAuthentication], ofItemAtPath: folderPath)
    
}

func updateDefaultConfig() {
    let userName = "SauvikDolui"
    var config = Realm.Configuration()
    config.fileURL = config.fileURL!.deletingPathExtension().appendingPathComponent("\(userName).realm")
    Realm.Configuration.defaultConfiguration = config
}


func realmFromCustomConfig() {
    let config = Realm.Configuration(fileURL: Realm.Configuration().fileURL!.deletingPathExtension().appendingPathComponent("user_name.realm"),
                                     readOnly: true)
    
    let user_realm = try! Realm(configuration: config)
                                   
}

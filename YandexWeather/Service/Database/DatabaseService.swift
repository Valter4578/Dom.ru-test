//
//  DatabaseService.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import Foundation
import RealmSwift

protocol DatabaseService {
    func save<T: Object>(object: T)
    func save<T: Object>(objects: [T])
    func delete<T: Object>(object: T)
    func delete<T: Object>(objects: [T])
    func deleteAll<T: Object>(of type: T.Type)
    
    func fetch<T: Object>(of type: T.Type) -> [T]
}

class DefaultDatabaseService: DatabaseService {
    // MARK:- Private functions
    private func defaultRealm() -> Realm {
        do {
            let realm = try Realm()
            return realm
        } catch {
            fatalError("can't instantiate realm")
        }
    }
    
    // MARK:- Functions
    func save<T>(object: T) where T : Object {
        let realm = defaultRealm()
        try! realm.write {
            realm.add(object)
        }
    }
    
    func save<T>(objects: [T]) where T : Object {
        let realm = defaultRealm()
        try! realm.write {
            realm.add(objects)
        }
    }
    
    func delete<T>(object: T) where T : Object {
        let realm = defaultRealm()
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func delete<T>(objects: [T]) where T : Object {
        let realm = defaultRealm()
        try! realm.write {
            realm.delete(objects)
        }
    }
    
    func deleteAll<T>(of type: T.Type) where T : Object {
        let realm = defaultRealm()
        let objects = realm.objects(type)
        try! realm.write {
            realm.delete(objects)
        }
    }
    
    func fetch<T>(of type: T.Type) -> [T] where T : Object {
        let realm = defaultRealm()
        let objects = realm.objects(type)
        return objects.compactMap { $0 }
    }
}

//
//  UserDefaultsManager.swift
//  Reminder
//
//  Created by Gabriel Roveri on 15/04/25.
//

import Foundation

final class UserDefaultsManager {
    private static let userKey = "userKey"
    
    static func saveUser(_ user: User) {
        if let data = try? JSONEncoder().encode(user){
            UserDefaults.standard.set(data, forKey: userKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func loadUser() -> User? {
        guard let data = UserDefaults.standard.data(forKey: userKey) else { return nil }
        
        if let data = try? JSONDecoder().decode(User.self, from: data) {
            return data
        }
        
        return nil
    }
    
    static func removeUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
        UserDefaults.standard.synchronize()
    }
}

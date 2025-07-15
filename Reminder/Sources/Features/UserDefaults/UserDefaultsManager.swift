//
//  UserDefaultsManager.swift
//  Reminder
//
//  Created by Gabriel Roveri on 15/04/25.
//

import Foundation
import UIKit

final class UserDefaultsManager {
    private static let userKey = "userKey"
    private static let userNameKey = "userNameKey"
    private static let profileImageKey = "profileImageKey"

    static func saveUser(_ user: User) {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: userKey)
            UserDefaults.standard.synchronize()
        }
    }

    static func saveUserName(_ name: String) {
        UserDefaults.standard.set(name, forKey: userNameKey)
        UserDefaults.standard.synchronize()
    }

    static func saveProfileImage(_ image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(imageData, forKey: profileImageKey)
        }
    }

    static func loadProfileImage() -> UIImage? {
        if let imageData = UserDefaults.standard.data(forKey: profileImageKey) {
            return UIImage(data: imageData)
        }

        return UIImage(systemName: "person.circle")
    }

    static func loadUser() -> User? {
        guard let data = UserDefaults.standard.data(forKey: userKey) else { return nil }

        if let data = try? JSONDecoder().decode(User.self, from: data) {
            return data
        }

        return nil
    }

    static func loadUserName() -> String? {
        return UserDefaults.standard.string(forKey: userNameKey)
    }

    static func removeUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
        UserDefaults.standard.removeObject(forKey: userNameKey)
        UserDefaults.standard.removeObject(forKey: profileImageKey)
        UserDefaults.standard.synchronize()
    }

    static func removeUserName() {
        UserDefaults.standard.removeObject(forKey: userNameKey)
        UserDefaults.standard.synchronize()
    }
}

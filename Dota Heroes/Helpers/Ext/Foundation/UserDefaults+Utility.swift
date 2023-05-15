//
//  UserDefaults+Utility.swift
//  Dota Heroes
//
//  Created by Tedjakusuma, Ferdinand on 15/05/23.
//  Copyright © 2023 Tiket.com. All rights reserved.
//

import Foundation

extension UserDefaults {

    private enum Keys {
        static let coreDataCreatedAt = "coreDataCreatedAt"

    }

    class var coreDataCreatedAt: Date {
        get {
            let rawValue = UserDefaults.standard.object(forKey: Keys.coreDataCreatedAt) as? Date
            return rawValue ?? Date()
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.coreDataCreatedAt)
        }
    }
}

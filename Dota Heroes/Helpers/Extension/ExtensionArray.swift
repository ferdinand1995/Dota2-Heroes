//
//  ExtensionArray.swift
//  Dota Heroes
//
//  Created by Ferdinand on 02/08/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

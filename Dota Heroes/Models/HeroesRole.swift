//
//  HeroesRole.swift
//  Dota Heroes
//
//  Created by Tedjakusuma, Ferdinand on 05/05/23.
//  Copyright © 2023 Tiket.com. All rights reserved.
//

import Foundation

public enum HeroesPageType {
    case roles
    case heroes
}

struct HeroesRole: Codable {
    var role: String?
    var isSelect: Bool = false
}

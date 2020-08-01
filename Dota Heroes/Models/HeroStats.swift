//
//  HeroStats.swift
//  Dota Heroes
//
//  Created by Ferdinand on 01/08/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import Foundation

struct HeroStats: Codable {
    
    var last_update: String?
    var list_heroes: [Hero]?
    
    enum CodingKeys: String, CodingKey {
        case last_update
        case list_heroes = "list_heroes"
    }
}

//
//  Hero.swift
//  Dota Heroes
//
//  Created by Ferdinand on 01/08/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import Foundation

struct Hero: Codable {
    
    let hero_id: Int?
    let name: String?
    let localized_name: String?
    let roles: [String]?
    let img: String?
    let icon: String?
    
    enum CodingKeys: String, CodingKey {
        case hero_id = "id"
        case name
        case localized_name
        case roles
        case img
        case icon
    }
}

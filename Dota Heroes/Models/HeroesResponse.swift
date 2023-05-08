//
//  Hero.swift
//  Dota Heroes
//
//  Created by Ferdinand on 01/08/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import Foundation

struct HeroesResponse: Codable {

    var hero_id: Int?
    var name: String?
    var localized_name: String?
    var primary_attr: String?
    var attack_type: String?
    var roles: [String]?
    var img: String?
    var icon: String?
    var base_health: Int?
    var base_attack_max: Int?
    var move_speed: Int?

    enum CodingKeys: String, CodingKey {
        case hero_id = "id"
        case name
        case localized_name
        case roles
        case img
        case icon
    }
}

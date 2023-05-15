//
//  HeroDetail.swift
//
//
//  Created by Tedjakusuma, Ferdinand on 09/05/23.
//

import Foundation

// MARK: - HeroDetail
struct HeroDetail: Codable {

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
    var base_mana: Int?
    var base_armor: Int?
    var similar_hero: [HeroDetail]?

    enum CodingKeys: String, CodingKey {
        case hero_id = "id"
        case name
        case localized_name
        case roles
        case img
        case icon
        case primary_attr
        case attack_type
        case base_health
        case base_attack_max
        case move_speed
        case base_mana
        case base_armor
        case similar_hero
    }
}

//
//  File.swift
//
//
//  Created by Tedjakusuma, Ferdinand on 09/05/23.
//

import Foundation

class HeroDetailHeaderVM {
    let imgUrl: String
    let name: String
    let roles: String
    let attackTypeIsRange: Bool
    init(_ heroDetail: HeroDetail) {
        self.imgUrl = "https://api.opendota.com" + (heroDetail.img ?? "")
        self.name = heroDetail.localized_name ?? ""
        if let roles = heroDetail.roles {
            self.roles = roles.joined(separator: ", ")
        } else {
            self.roles = ""
        }
        if let attackType = heroDetail.attack_type {
            self.attackTypeIsRange = (attackType.lowercased().contains("range")) ? true : false
        } else {
            self.attackTypeIsRange = false
        }
    }
}

class HeroDetailContentVM {

    let health: String
    let baseAttack: String
    let moveSpeed: String
    let baseMana: String
    let primaryAttr: String
    let armor: String
    init(_ heroDetail: HeroDetail) {
        if let baseAttack = heroDetail.base_attack_max {
            self.baseAttack = String(baseAttack)
        } else {
            self.baseAttack = ""
        }
        if let health = heroDetail.base_health {
            self.health = String(health)
        } else {
            self.health = ""
        }
        if let moveSpeed = heroDetail.move_speed {
            self.moveSpeed = String(moveSpeed)
        } else {
            self.moveSpeed = ""
        }
        if let baseMana = heroDetail.base_mana {
            self.baseMana = String(baseMana)
        } else {
            self.baseMana = ""
        }
        if let primaryAttr = heroDetail.primary_attr {
            self.primaryAttr = String(primaryAttr)
        } else {
            self.primaryAttr = ""
        }
        if let armor = heroDetail.base_armor {
            self.armor = String(armor)
        } else {
            self.armor = ""
        }
    }
}

class HeroDetailFooterVM {
    var similarHero1: String?
    var similarHero2: String?
    var similarHero3: String?
    init(_ similarHero: [HeroDetail]) {
        let baseURL: String = "https://api.opendota.com"
        for item in 0..<similarHero.count {
            switch item {
            case 0:
                self.similarHero1 = baseURL + (similarHero[item].img ?? "")
            case 1:
                self.similarHero2 = baseURL + (similarHero[item].img ?? "")
            case 2:
                self.similarHero3 = baseURL + (similarHero[item].img ?? "")
            default:
                break
            }
        }
    }
}

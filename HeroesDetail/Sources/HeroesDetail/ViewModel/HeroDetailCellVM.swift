//
//  File.swift
//  
//
//  Created by Tedjakusuma, Ferdinand on 09/05/23.
//

import Foundation

class HeroDetailHeaderVM {
    
}

class HeroDetailContentVM {
    
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

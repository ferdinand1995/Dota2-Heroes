//
//  ViewModel.swift
//  Dota Heroes
//
//  Created by Ferdinand on 01/08/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import Foundation
import UIKit.UIImage

public class ViewModel {
    
    let networkLayer = Networking()
    
    var heroes = HeroStats()
    var roles = [Roles]()
    var listOfHeroes: Int = 0
       
    func fetchListHeroStat() {
        
        networkLayer.getRequestData(urlRequest: ApiConstant.API_HERO_STATS, headers: nil, parameters: nil, successHandler: { (heroes: [Hero]) in
            
            self.heroes.list_heroes = heroes
            
            self.listOfHeroes = heroes.count
            
            self.sortRoles(listOfHeroes: &(self.heroes.list_heroes)!)

        }) { (error: String) in
            print(error)
        }
      
    }
    
    func sortRoles(listOfHeroes: inout [Hero]) {
        for obj in listOfHeroes {
            guard let roles = obj.roles else { return }
            for objRole in roles {
                let role = Roles(hero_roles: objRole)
                self.roles.append(role)
            }
        }
        self.roles = roles.removingDuplicates()
    }
    
}

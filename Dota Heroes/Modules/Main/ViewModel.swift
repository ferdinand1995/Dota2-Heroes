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
    // MARK: Binding View
    var roles: Box<[String]> = Box([])
    var heroStat: Box<HeroStats> = Box(HeroStats())
       
    func fetchListHeroStat(completion: @escaping (() -> Void)) {
        
        networkLayer.getRequestData(urlRequest: ApiConstant.API_HERO_STATS, headers: nil, parameters: nil, successHandler: { (heroes: [Hero]) in
            
            self.sortRoles(listOfHeroes: heroes)
            
            completion()

        }) { (error: String) in
            print(error)
        }
      
    }

    func sortRoles(listOfHeroes: [Hero]) {
        self.heroStat.value.list_heroes = listOfHeroes
        
        roles.value.append("All")
        for obj in listOfHeroes {
            guard let roles = obj.roles else { return }
            for objRole in roles {
                self.roles.value.append(objRole)
            }
        }
        self.roles.value = roles.value.removingDuplicates()
    }

}

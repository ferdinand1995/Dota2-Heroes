//
//  HeroesRepository.swift
//  Dota Heroes
//
//  Created by Tedjakusuma, Ferdinand on 06/05/23.
//  Copyright © 2023 Tiket.com. All rights reserved.
//

import Foundation
import CoreData

protocol HeroesRepositoryInterface {
    func getHeroes(predicate: NSPredicate?) -> Result<[HeroesResponse], Error>
    func create(_ heroesResponse: HeroesResponse) -> Result<Bool, Error>
    func deleteAllHeroes()
}

class HeroesRepository {
    private let repository: CoreDataRepository<Hero>
    init(context: NSManagedObjectContext) {
        self.repository = CoreDataRepository<Hero>(managedObjectContext: context)
    }
}

extension HeroesRepository: HeroesRepositoryInterface {
    func deleteAllHeroes() {
        _ = repository.deleteAllRecords()
    }

    @discardableResult func getHeroes(predicate: NSPredicate?) -> Result<[HeroesResponse], Error> {
        let result = repository.get(predicate: predicate, sortDescriptors: nil)
        switch result {
        case .success(let heroes):
            let heroes = heroes.map { heroes -> HeroesResponse in
                return heroes.toDomainModel()
            }

            return .success(heroes)
        case .failure(let error):
            return .failure(error)
        }
    }

    @discardableResult func create(_ response: HeroesResponse) -> Result<Bool, Error> {
        let result = repository.create()
        switch result {
        case .success(let hero):
            hero.attack_type = response.attack_type
            if let base_attack_max = response.base_attack_max {
                hero.base_attack_max = String(base_attack_max)
            }
            if let base_health = response.base_health {
                hero.base_health = String(base_health)
            }
            hero.img = response.img
            hero.localized_name = response.localized_name
            if let move_speed = response.move_speed {
                hero.move_speed = String(move_speed)
            }
            if let base_armor = response.base_armor {
                hero.base_armor = String(base_armor)
            }
            if let base_mana = response.base_mana {
                hero.base_mana = String(base_mana)
            }
            hero.primary_attr = response.primary_attr
            hero.roles = response.roles
            return .success(true)
        case .failure(let error):
            return .failure(error)
        }
    }

}

extension Hero: DomainModel {
    func toDomainModel() -> HeroesResponse {
        var heroesResponse = HeroesResponse()
        heroesResponse.attack_type = self.attack_type
        if let base_attack_max = self.base_attack_max {
            heroesResponse.base_attack_max = Int(base_attack_max)
        }
        if let base_health = self.base_health {
            heroesResponse.base_health = Int(base_health)
        }
        heroesResponse.img = self.img
        heroesResponse.localized_name = self.localized_name
        if let move_speed = self.move_speed {
            heroesResponse.move_speed = Int(move_speed)
        }
        if let base_armor = self.base_armor {
            heroesResponse.base_armor = Double(base_armor)
        }
        if let base_mana = self.base_mana {
            heroesResponse.base_mana = Int(base_mana)
        }
        heroesResponse.primary_attr = self.primary_attr
        heroesResponse.roles = self.roles
        return heroesResponse
    }
}

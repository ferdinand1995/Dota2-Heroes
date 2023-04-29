//
//  HeroesVM.swift
//  Dota Heroes
//
//  Created by Ferdinand on 01/08/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import Foundation
import UIKit.UIImage
import CoreData

public class HeroesVM: ParentViewModel {
    
    private let networkLayer = Networking()
    
    // MARK: Binding View
    var roles: Observable<[String]> = Observable([])
    var didTapBack: (() -> Void)?
    var didSelect: (() -> Void)?
    var heroesResponse: Observable<[HeroesResponse]> = Observable([])
    
    func fetchHeroesAPI() {
        self.isLoadingStated(true)
        networkLayer.getRequestData(urlRequest: ApiConstant.API_HERO_STATS, headers: nil, parameters: nil, successHandler: { (heroes: [HeroesResponse]) in
            self.isLoadingStated(false)
            self.heroesResponse.value = heroes
        }) { error in
            self.isLoadingStated(false)
            self.onErrorBlock?(error)
        }
    }
    
    private func sortRoles(_ listOfHeroes: [HeroesResponse]) {
        self.heroesResponse.value = listOfHeroes
        
        roles.value.append("All")
        for obj in listOfHeroes {
            guard let roles = obj.roles else { return }
            for objRole in roles {
                self.roles.value.append(objRole)
            }
        }
        self.roles.value = roles.value.removeDuplicates()
    }
    
    func itemInHeroesCount() -> Int {
        return heroesResponse.value.count
    }
    
    func addResponseToCoreData(_ managedContext: NSManagedObjectContext) {
        
        do {
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Hero")
            let deleteALL = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            try managedContext.execute(deleteALL)
            
            do {
                try managedContext.save()
                print("Success")
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        } catch {
            print ("There is an error in deleting records")
        }
        
        for hero in self.heroesResponse.value {
            let entity = NSEntityDescription.entity(forEntityName: "Hero", in: managedContext)
            let newHeroes = NSManagedObject(entity: entity!, insertInto: managedContext)
            
            guard let heroId = hero.hero_id else { return }
            newHeroes.setValue(String(heroId), forKey: "hero_id")
            newHeroes.setValue(hero.name, forKey: "name")
            newHeroes.setValue(hero.localized_name, forKey: "localized_name")
            newHeroes.setValue(hero.primary_attr, forKey: "primary_attr")
            newHeroes.setValue(hero.attack_type, forKey: "attack_type")
            newHeroes.setValue(hero.roles?.description, forKey: "roles")
            newHeroes.setValue(hero.img?.description, forKey: "img")
            newHeroes.setValue(hero.icon?.description, forKey: "icon")
            guard let baseHealth = hero.base_health else { return }
            newHeroes.setValue(String(baseHealth), forKey: "base_health")
            guard let baseAttackMax = hero.base_attack_max else { return }
            newHeroes.setValue(String(baseAttackMax), forKey: "base_attack_max")
            guard let moveSpeed = hero.move_speed else { return }
            newHeroes.setValue(String(moveSpeed), forKey: "move_speed")
        }
        
        do {
            try managedContext.save()
            print("Success")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func fetchCoreData(_ managedContext: NSManagedObjectContext, completion: @escaping (() -> Void)) {
        
        let all = NSFetchRequest<Hero>(entityName: "Hero")
        var listOfHeroes = [Hero]()
        
        do {
            let fetched = try managedContext.fetch(all)
            listOfHeroes = fetched
        } catch {
            let nserror = error as NSError
            //TODO: Handle Error
            print(nserror.description)
        }
        
        var tempHeroesResponse = [HeroesResponse]()
        for obj in listOfHeroes {
            
            let stringAsData = obj.roles?.data(using: String.Encoding.utf16)
            let arrayRole: [String] = try! JSONDecoder().decode([String].self, from: stringAsData!)
            
            let id:Int? = Int(obj.hero_id ?? "")
            let health:Int? = Int(obj.base_health ?? "")
            let attack:Int? = Int(obj.base_attack_max ?? "")
            let speed:Int? = Int(obj.move_speed ?? "")

            let hero = HeroesResponse(hero_id: id, name: obj.name, localized_name: obj.localized_name, primary_attr: obj.primary_attr, attack_type: obj.attack_type, roles: arrayRole, img: obj.img, icon: obj.icon, base_health: health, base_attack_max: attack, move_speed: speed)
            
            tempHeroesResponse.append(hero)
        }
        
        self.sortRoles(tempHeroesResponse)
        completion()
    }
    
    func convertToJSONArray(moArray: [NSManagedObject]) -> Any {
        var jsonArray: [[String: Any]] = []
        for item in moArray {
            var dict: [String: Any] = [:]
            for attribute in item.entity.attributesByName {
                //check if value is present, then add key to dictionary so as to avoid the nil value crash
                if let value = item.value(forKey: attribute.key) {
                    dict[attribute.key] = value
                }
            }
            jsonArray.append(dict)
        }
        return jsonArray
    }
    
}

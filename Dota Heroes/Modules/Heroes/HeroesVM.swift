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
import NavigationKit
import Combine

class HeroesCellVM {
    let name: String
    let imageURL: URL?

    init(name: String?, imageURL: String?) {
        self.name = name ?? "...."
        let url: String = ApiConstant.BASE_URL + (imageURL ?? "")
        self.imageURL = URL(string: url)
    }
}

public class HeroesVM: BaseViewModel {

    private let networkLayer = Networking()
    let heroesPageType: [HeroesPageType] = [.roles, .heroes]
    private let context = CoreDataContextProvider()

    // MARK: Binding View
    private(set) var roles = [HeroesRole]()
    @Published private(set) var heroesResponse = [HeroesResponse](repeating: HeroesResponse(), count: 16)

    private func fetchHeroesAPI() {
        self.isLoadingStated(true)
        networkLayer.getRequestData(urlRequest: ApiConstant.API_HERO_STATS, headers: nil, parameters: nil, successHandler: { (heroes: [HeroesResponse]) in
            self.isLoadingStated(false)
            self.cacheResponse(heroes)
            self.roles = self.sortRoles(heroes)
            self.heroesResponse = heroes
        }) { error in
            self.isLoadingStated(false)
            self.onErrorBlock?(error)
        }
    }

    private func sortRoles(_ heroes: [HeroesResponse]) -> [HeroesRole] {
        var result = [HeroesRole]()
        let arrayRoles: [[String]] = heroes.compactMap({ $0.roles })
        let roles: [String] = Array(Set(arrayRoles.flatMap({ $0 })))
        for item in roles {
            result.append(HeroesRole(role: item))
        }
        result.insert(HeroesRole(role: "All", isSelect: true), at: 0)
        return result
    }

    func updateSelectedRoles(_ item: Int) {
        self.roles[item].isSelect = true
        guard let filteredRole: String = self.roles[item].role, let heroes = fetchHeroesData() else { return }
        if filteredRole.lowercased() == "all" {
            self.heroesResponse = heroes
        } else {
            self.heroesResponse = heroes.filter({ hero in
                guard let heroRole = hero.roles else { return false }
                return heroRole.contains(filteredRole)
            })
        }
    }

    func removedSelectedRoles() {
        for index in roles.indices {
            roles[index].isSelect = false
        }
    }

    func itemInHeroesCount() -> Int {
        return heroesResponse.count
    }

    func cacheResponse(_ heroesResponse: [HeroesResponse]) {
        let heroesRepository = HeroesRepository(context: context.viewContext)
        heroesRepository.deleteAllHeroes()
        for response in heroesResponse {
            heroesRepository.create(response)
        }
        do {
            try context.viewContext.save()
        } catch {
            context.viewContext.rollback()
        }
    }

    func fetchData() {
        if let heroes = fetchHeroesData() {
            self.roles = self.sortRoles(heroes)
            self.heroesResponse = heroes
        } else {
            self.fetchHeroesAPI()
        }
    }

    private func fetchHeroesData() -> [HeroesResponse]? {
        let heroesRepository = HeroesRepository(context: context.viewContext)
        let result = heroesRepository.getHeroes(predicate: nil)
        switch result {
        case .success(let heroes):
            if heroes.count > 0 {
                return heroes
            } else {
                return nil
            }
        case .failure(_):
            return nil
        }
    }

}

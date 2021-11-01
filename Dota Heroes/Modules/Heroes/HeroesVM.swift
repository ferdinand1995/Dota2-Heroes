//
//  HeroesVM.swift
//  Dota Heroes
//
//  Created by Ferdinand on 01/08/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import Foundation

public class HeroesVM: ParentViewModel {
    
    private let networkLayer = Networking()
    
    // MARK: Binding View
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
    
    func itemInHeroesCount() -> Int {
        return heroesResponse.value.count
    }
}

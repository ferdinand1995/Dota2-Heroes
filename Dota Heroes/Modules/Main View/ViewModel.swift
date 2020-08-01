//
//  ViewModel.swift
//  Dota Heroes
//
//  Created by Ferdinand on 01/08/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import Foundation

class ViewModel {
    
    let networkLayer = Networking()
    
    var heroStats: HeroStats?
        
    init(withModel heroStats: inout HeroStats) {
        self.heroStats = heroStats
    }
    
    func loadFromLocal(){
        
        guard let url = Bundle.main.path(forResource: "example_contract", ofType: "json") else { return }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: url), options: .mappedIfSafe) else { return }
        if let heroStats: HeroStats = try? JSONDecoder().decode(HeroStats.self, from: data) {
            self.heroStats = heroStats
        }
    }
    
    func itemsInSection() -> Int? {
        return self.heroStats?.list_heroes?.count
    }
}

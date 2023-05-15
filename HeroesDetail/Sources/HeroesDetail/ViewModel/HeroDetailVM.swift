//
//  File.swift
//  
//
//  Created by Tedjakusuma, Ferdinand on 03/05/23.
//

import Foundation
import NavigationKit

enum DetailCellType {
    case header
    case content
    case footer
}

class HeroDetailVM: BaseViewModel {
    
    private var selectedHero: HeroDetail?
    let detailCellType: [DetailCellType] = [.header, .content, .footer]
    
    func setSelectedHero(_ heroDetail: HeroDetail) {
        self.selectedHero = heroDetail
    }
    
    func setHeader() -> HeroDetailHeaderVM {
        return HeroDetailHeaderVM(selectedHero ?? HeroDetail())
    }
    
    func setContent() -> HeroDetailContentVM {
        return HeroDetailContentVM(selectedHero ?? HeroDetail())
    }
    
    func setFooter() -> HeroDetailFooterVM {
        return HeroDetailFooterVM(selectedHero?.similar_hero ?? [HeroDetail]())
    }
}

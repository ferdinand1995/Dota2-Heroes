//
//  ListHeroesCollectionViewCell.swift
//  Dota Heroes
//
//  Created by Ferdinand on 04/08/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import UIKit
import Kingfisher

class ListHeroesCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellIdentifier = "heroesCell"
    
    var viewModelDelegate: ViewModel? {
        didSet {
            collectionViewHero.reloadData()
        }
    }

    let spacingOfItemPerRow: CGFloat = 0
    let numberOfItemPerRow: CGFloat = 3.0

    @IBOutlet weak var collectionViewHero: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionViewHero.dataSource = self
        collectionViewHero.delegate = self
        
        collectionViewHero.register(UINib.init(nibName: "HeroCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        collectionViewHero.showsVerticalScrollIndicator = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModelDelegate?.listOfHeroes ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! HeroCollectionViewCell
        
        if let heroes = viewModelDelegate?.heroes.list_heroes {
            cell.labelNameHero.text = heroes[indexPath.item].localized_name
            if let img = heroes[indexPath.item].img {
                let url = URL(string: "\(ApiConstant.BASE_URL)\(img)")
                cell.imageViewHero.kf.setImage(with: url, options: [.transition(.fade(0.3))])
            }
            cell.imageViewHero.kf.indicatorType = .activity
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenRect = self.collectionViewHero.safeAreaLayoutGuide.layoutFrame
        let spaceBetweenGrid = numberOfItemPerRow + 1
        let width = screenRect.width - spacingOfItemPerRow * spaceBetweenGrid
        let height = width / numberOfItemPerRow
            
        return CGSize(width: floor(height), height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: spacingOfItemPerRow, bottom: 8, right: spacingOfItemPerRow)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacingOfItemPerRow
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacingOfItemPerRow
    }
        
}

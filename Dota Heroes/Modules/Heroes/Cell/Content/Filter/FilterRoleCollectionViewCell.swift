//
//  FilterRoleCollectionViewCell.swift
//  Dota Heroes
//
//  Created by Ferdinand on 04/08/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import UIKit

class FilterRoleCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellIdentifier = "roleHeroCell"
    
    var selectedItem: Int?
    
    var viewModelDelegate: HeroesVM? {
        didSet {
            collectionViewFilter.reloadData()
        }
    }
    
    @IBOutlet weak var collectionViewFilter: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionViewFilter.setCollectionViewLayout(layout, animated: false)
        
        collectionViewFilter.dataSource = self
        collectionViewFilter.delegate = self
        
        collectionViewFilter.register(UINib.init(nibName: "RolesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        collectionViewFilter.showsVerticalScrollIndicator = false
        collectionViewFilter.showsHorizontalScrollIndicator = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var itemsInSection = Int()
        
        viewModelDelegate?.roles.bind({ (roles) in
            itemsInSection = roles.count
        })
        return itemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! RolesCollectionViewCell
        
        viewModelDelegate?.roles.bind({ (roles) in
            DispatchQueue.main.async {
                cell.labelRole.text = roles[indexPath.item]
            }
        })
                
        if selectedItem == indexPath.item {
            cell.didSelect(select: true)
        }else {
            cell.didSelect(select: false)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedItem = indexPath.item
        collectionView.reloadItems(at: [indexPath])
        
    }
}

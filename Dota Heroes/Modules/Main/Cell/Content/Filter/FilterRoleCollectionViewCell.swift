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
    
    var viewModelDelegate: ViewModel? {
        didSet {
            collectionViewFilter.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModelDelegate?.roles.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! RolesCollectionViewCell
        
        cell.labelRole.text = viewModelDelegate?.roles[indexPath.item].hero_roles
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 96, height: collectionView.frame.size.height)
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
    
}

//
//  ViewController.swift
//  Dota Heroes
//
//  Created by Ferdinand on 31/07/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    
    private let viewModel = ViewModel()

    let cellHeroIdentifier = "listHeroesCell"
    let cellFilterIdentifier = "filterCell"
    let headerIdentifier = "headerCellId"
   
    
    //MARK: Initialize View
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel.fetchListHeroStat()
        
        let layout =  StretchyHeaderViewFlowLayout()
        self.collectionView.collectionViewLayout = layout
        
        self.collectionView.register(UINib.init(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        self.collectionView.register(UINib(nibName: "FilterRoleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellFilterIdentifier)
        self.collectionView.register(UINib(nibName: "ListHeroesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellHeroIdentifier)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: CollectionView Delegate
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //MARK: Header Cell
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.safeAreaLayoutGuide.layoutFrame.width, height: 240)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            let header: HeaderCollectionReusableView  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! HeaderCollectionReusableView

            return header            
        default:
            fatalError("Unexpected element kind")
        }
    }
    
    //MARK: Content Cell
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: 80)
        }else {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.safeAreaLayoutGuide.layoutFrame.size.height)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellFilterIdentifier, for: indexPath) as! FilterRoleCollectionViewCell
            
            cell.viewModelDelegate = viewModel
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellHeroIdentifier, for: indexPath) as! ListHeroesCollectionViewCell

            cell.viewModelDelegate = viewModel
            return cell
            
        }
    }
    /*
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        coordinator?.detailDescription()
    }*/
}

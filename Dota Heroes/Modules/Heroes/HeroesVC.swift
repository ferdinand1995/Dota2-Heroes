//
//  HeroesVC.swift
//  Dota Heroes
//
//  Created by Ferdinand on 31/07/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import UIKit
import CoreData

class HeroesVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, Storyboarded {

    weak var coordinator: MainCoordinator?

    private let viewModel = HeroesVM()

    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initViewModel()
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
    
    func initUI() {
        collectionView.register(nibWithCellClass: HeroCollectionViewCell.self)
        collectionView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: HeaderCollectionReusableView.self)

        let layout = StretchyHeaderViewFlowLayout()
        self.collectionView.collectionViewLayout = layout
    }
    
    func initViewModel() {
        viewModel.onErrorBlock = { error in
            print(error)
        }
    
        viewModel.heroesResponse.bind { _ in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        viewModel.fetchHeroesAPI()
    }
    
    /// - NOTE: Header Cell
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var itemsInSection = Int()
        viewModel.heroesResponse.bind({ heroStat in
            itemsInSection = heroStat.count
        })
        return itemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.safeAreaLayoutGuide.layoutFrame.width, height: 240)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      
            let header: HeaderCollectionReusableView  = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: HeaderCollectionReusableView.self, for: indexPath)
            
            return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withClass: HeroCollectionViewCell.self, for: indexPath)
            
        return cell
           
    }
}

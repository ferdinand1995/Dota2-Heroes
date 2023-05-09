//
//  ListOfHeroesCell.swift
//  Dota Heroes
//
//  Created by Ferdinand on 04/08/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import UIKit

class ListOfHeroesCell: UICollectionViewCell {

    private var viewModel: HeroesVM?
    let spacingOfItemPerRow: CGFloat = 0
    let numberOfItemPerRow: CGFloat = 3.0

    @IBOutlet private weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(nibWithCellClass: HeroCell.self)
        collectionView.showsVerticalScrollIndicator = false
    }

    public func configCell(with viewModel: HeroesVM) {
        self.viewModel = viewModel
        self.collectionView.reloadData()
    }
}

// MARK: Data Source
extension ListOfHeroesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.itemInHeroesCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: HeroCell.self, for: indexPath)
        guard let viewModel = viewModel else { return cell }
        let heroStat = viewModel.heroesResponse[indexPath.item]
        let heroName: String? = heroStat.localized_name
        let img: String? = heroStat.img
        cell.configCell(with: HeroesCellVM(name: heroName, imageURL: img))
        return cell
    }
}

// MARK: Flow Layout
extension ListOfHeroesCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let screenRect = self.collectionView.safeAreaLayoutGuide.layoutFrame
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

// MARK: Delegate
extension ListOfHeroesCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectHero(indexPath.item)
    }
}

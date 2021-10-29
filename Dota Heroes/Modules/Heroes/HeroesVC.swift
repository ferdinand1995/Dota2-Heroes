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
    let spacingOfItemPerRow: CGFloat = 0
    let numberOfItemPerRow: CGFloat = 3
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
        collectionView.register(nibWithCellClass: HeroCell.self)
        collectionView.register(nib: UINib(nibName: String(describing: HeaderCollectionReusableView.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: HeaderCollectionReusableView.self)
        collectionView.showsVerticalScrollIndicator = false
        let layout = StretchyHeaderViewFlowLayout()
        self.collectionView.collectionViewLayout = layout
    }

    func initViewModel() {

        viewModel.isLoadingStated = { isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self.view.makeToastActivity(.center)
                } else {
                    self.view.hideToastActivity()
                }
            }
        }

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

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemInHeroesCount()
    }

    /// - NOTE: Header Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.safeAreaLayoutGuide.layoutFrame.width, height: 240)
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: HeaderCollectionReusableView.self, for: indexPath)

        return header
    }

    /// - NOTE: Content Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let screenRect = collectionView.safeAreaLayoutGuide.layoutFrame
        let spaceBetweenGrid = numberOfItemPerRow + 1
        let width = screenRect.width - spacingOfItemPerRow * spaceBetweenGrid
        let height = width / numberOfItemPerRow

        return CGSize(width: floor(height), height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: spacingOfItemPerRow, bottom: 0, right: spacingOfItemPerRow)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacingOfItemPerRow
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacingOfItemPerRow
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withClass: HeroCell.self, for: indexPath)

        cell.imageViewHero.kf.indicatorType = .activity
        viewModel.heroesResponse.bind { heroStat in
            DispatchQueue.main.async {
                cell.labelNameHero.text = heroStat[indexPath.item].localized_name

                let urlImage = heroStat[indexPath.item].img
                let url = URL(string: "\(ApiConstant.BASE_URL)\(urlImage ?? "")")
                cell.imageViewHero.kf.setImage(with: url, options: [.transition(.fade(0.3))])
            }
        }

        return cell

    }
}

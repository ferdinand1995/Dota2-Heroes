//
//  HeroesVC.swift
//  Dota Heroes
//
//  Created by Ferdinand on 31/07/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import UIKit
import Kingfisher

class HeroesVC: UICollectionViewController, Storyboarded {

    weak var coordinator: MainCoordinator?
    private let viewModel = HeroesVM()
    let spacingOfItemPerRow: CGFloat = 0
    let numberOfItemPerRow: CGFloat = 3
    private var previousStatusBarHidden = false

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

    // MARK: Initialize
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
                    self.collectionView.reloadData()
                }
            }
        }

        viewModel.onErrorBlock = { error in
            DispatchQueue.main.async {
                self.view.hideToastActivity()
                let alertController = UIAlertController(title: "Loading error", message: "There was a problem loading the feed: \(error.msg)", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertController, animated: true)
            }
        }

        viewModel.fetchHeroesAPI()
    }

    // MARK: CollectionView Delegate
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemInHeroesCount()
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: HeaderCollectionReusableView.self, for: indexPath)

        return header
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withClass: HeroCell.self, for: indexPath)

        cell.heroImageView.kf.indicatorType = .activity
        viewModel.heroesResponse.bind { heroStat in

            cell.heroNameLabel.text = heroStat[indexPath.item].localized_name
            let urlImage = heroStat[indexPath.item].img
            let url = URL(string: "\(ApiConstant.BASE_URL)\(urlImage ?? "")")
            cell.heroImageView.kf.setImage(with: url, options: [.transition(.fade(0.3))]) { _ in
                cell.heroNameLabel.fadeIn()
            }
        }
        return cell
    }

    //MARK: - Scroll View Delegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if previousStatusBarHidden != shouldHideStatusBar {

            UIView.animate(withDuration: 0.3, animations: {
                self.setNeedsStatusBarAppearanceUpdate()
            })

            previousStatusBarHidden = shouldHideStatusBar
        }
    }

    //MARK: - Status Bar Appearance
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }

    override var prefersStatusBarHidden: Bool {
        return shouldHideStatusBar
    }

    private var shouldHideStatusBar: Bool {
        return collectionView.contentOffset.y > view.safeAreaInsets.top
    }
}

// MARK: CollectionView Delegate Flow
extension HeroesVC: UICollectionViewDelegateFlowLayout {
    /// - NOTE: Header Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.safeAreaLayoutGuide.layoutFrame.width, height: 240)
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
}

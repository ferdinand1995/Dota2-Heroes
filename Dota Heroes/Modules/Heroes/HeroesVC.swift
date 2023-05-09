//
//  HeroesVC.swift
//  Dota Heroes
//
//  Created by Ferdinand on 31/07/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import UIKit
import CoreData
import Combine

class HeroesVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let viewModel: HeroesVM
    private var previousStatusBarHidden: Bool = false
    private var bindings = Set<AnyCancellable>()

    // MARK: initialized
    init(_ viewModel: HeroesVM) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        collectionView.register(cellWithClass: ListOfRolesCell.self)
        collectionView.register(nibWithCellClass: ListOfHeroesCell.self)
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

        viewModel.$heroesResponse.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.collectionView.reloadData()
        }.store(in: &bindings)

        viewModel.fetchData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.heroesPageType.count
    }

    /// - NOTE: Header Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.safeAreaLayoutGuide.layoutFrame.width, height: 240)
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: HeaderCollectionReusableView.self, for: indexPath)
    }

    /// - NOTE: Content Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let type = viewModel.heroesPageType[indexPath.item]
        switch type {
        case .roles:
            return CGSize(width: collectionView.frame.width, height: 56)
        case .heroes:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let type = viewModel.heroesPageType[indexPath.item]
        switch type {
        case .roles:
            let cell = collectionView.dequeueReusableCell(withClass: ListOfRolesCell.self, for: indexPath)
            cell.configCell(with: viewModel)
            return cell
        case .heroes:
            let cell = collectionView.dequeueReusableCell(withClass: ListOfHeroesCell.self, for: indexPath)
            cell.configCell(with: viewModel)
            return cell
        }
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

//
//  ListOfRolesCell.swift
//  Dota Heroes
//
//  Created by Tedjakusuma, Ferdinand on 04/05/23.
//  Copyright © 2023 Tiket.com. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class ListOfRolesCell: UICollectionViewCell {

    private var viewModel: HeroesVM?

    lazy private var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RolesCell.self, forCellWithReuseIdentifier: String(describing: RolesCell.self))
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func initUI() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }

    public func configCell(with viewModel: HeroesVM) {
        self.viewModel = viewModel
        self.collectionView.reloadData()
    }
}

// MARK: Data Source
extension ListOfRolesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.roles.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RolesCell.self), for: indexPath) as? RolesCell, let viewModel = viewModel else { return UICollectionViewCell() }
        let data = viewModel.roles[indexPath.item]
        cell.configure(with: data.role ?? "", isSelected: data.isSelect)
        return cell
    }
}

// MARK: Flow Layout
extension ListOfRolesCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8
        )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = viewModel?.roles[indexPath.row].role ?? ""
        return CGSize(width: item.size(withAttributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .heavy)
        ]).width + 24, height: 44)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
}

extension ListOfRolesCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        select(row: indexPath.row)
    }

    private func select(row: Int, in section: Int = 0, animated: Bool = true) {
        guard let viewModel = viewModel, row < viewModel.roles.count else { return }
        viewModel.removedSelectedRoles()
        let indexPath = IndexPath(row: row, section: section)
        viewModel.updateSelectedRoles(indexPath.item)
        collectionView.reloadData {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

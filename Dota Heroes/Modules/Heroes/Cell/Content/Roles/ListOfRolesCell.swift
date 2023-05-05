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

    var cellWidth: CGFloat = 0
    private var data = [String]()
    var selectedCellIndexPath: IndexPath?

    lazy private var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
//        collectionView.delegate = self
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
        cellWidth = self.frame.width / 4
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
    }

    public func configCell(with viewModel: HeroesVM) {
        self.data = viewModel.roles
        self.collectionView.reloadData()
    }
}

// MARK: Data Source
extension ListOfRolesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RolesCell.self), for: indexPath) as? RolesCell else { return UICollectionViewCell() }

        cell.backgroundColor = indexPath.item % 2 == 0 ? .blue : .red
        cell.configure(with: data[indexPath.row])
        return cell
    }
}

// MARK: Flow Layout
extension ListOfRolesCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = self.frame.width / 2 - (cellWidth / 2)
        return UIEdgeInsets(
            top: 0,
            left: inset,
            bottom: 0,
            right: inset
        )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: cellWidth, height: cellWidth - 1)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        /// if decelerate doesnt occur, scrollToCell
        if !decelerate {
//            scrollToCell()
        } /// else wait until decleration ends to scrollToCell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        /// scroll to cell
//        scrollToCell()
    }
}

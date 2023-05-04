//
//  RolesCell.swift
//  Dota Heroes
//
//  Created by Ferdinand on 02/08/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import UIKit
import SnapKit

final class RolesCell: UICollectionViewCell {

    /// Title label
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.textAlignment = .center
        return label
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.attributedText = nil
    }

    private func initUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
            make.bottom.trailing.equalToSuperview().offset(-8)
        }
    }

    public func configure(with title: String, isSelected: Bool = false) {
        titleLabel.text = title
        backgroundColor = isSelected ? .green : .darkGray
    }
}

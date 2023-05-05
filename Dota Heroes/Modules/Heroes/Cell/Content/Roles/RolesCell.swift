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
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.8
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.textAlignment = .center
        return label
    }()

    private let roundedView = UIView()

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
        addSubview(roundedView)
        roundedView.layer.cornerRadius = 8
        roundedView.layer.masksToBounds = true
        roundedView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        roundedView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
            make.bottom.trailing.equalToSuperview().offset(-8)
        }
    }

    public func configure(with title: String, isSelected: Bool = false) {
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.preferredMaxLayoutWidth = 56
        roundedView.backgroundColor = isSelected ? .MAIN_RED_COLOR: .black
    }
}

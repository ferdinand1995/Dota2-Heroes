//
//  HeroDetailVC.swift
//
//
//  Created by Tedjakusuma, Ferdinand on 02/05/23.
//

import UIKit
import SnapKit

class HeroDetailVC: UIViewController {

    private let viewModel: HeroDetailVM

    init(_ viewModel: HeroDetailVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initUI()
    }

    private func initUI() {
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(nib: UINib(nibName: String(describing: HeroDetailHeaderCell.self), bundle: Bundle.module), withCellClass: HeroDetailHeaderCell.self)
        tableView.register(nib: UINib(nibName: String(describing: HeroDetailContentCell.self), bundle: Bundle.module), withCellClass: HeroDetailContentCell.self)
        tableView.register(nib: UINib(nibName: String(describing: HeroDetailFooterCell.self), bundle: Bundle.module), withCellClass: HeroDetailFooterCell.self)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: Data Source
extension HeroDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch viewModel.detailCellType[indexPath.item] {
        case .header:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeroDetailHeaderCell.self), for: indexPath) as? HeroDetailHeaderCell else { return UITableViewCell() }
            cell.confiCell(viewModel.setHeader())
            return cell
        case .content:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeroDetailContentCell.self), for: indexPath)
            return cell
        case .footer:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeroDetailFooterCell.self), for: indexPath) as? HeroDetailFooterCell else { return UITableViewCell() }
            cell.configCell(viewModel.setFooter())
            return cell
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.detailCellType.count
    }
}

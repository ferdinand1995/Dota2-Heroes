//
//  CoreUITableView.swift
//  Diabetic Educator
//
//  Created by DSS-Titus on 12/08/21.
//

import UIKit.UITableView

extension UITableView {

    func isContentLessThanTableViewHeight() -> Bool {
        if self.contentSize.height < self.frame.height {
            return true
        } else {
            return false
        }
    }

    /// SwifterSwift: Index path of last row in tableView.
    var indexPathForLastRow: IndexPath? {
        guard let lastSection = lastSection else { return nil }
        return indexPathForLastRow(inSection: lastSection)
    }

    /// SwifterSwift: Index of last section in tableView.
    var lastSection: Int? {
        return numberOfSections > 0 ? numberOfSections - 1: nil
    }

    /// SwifterSwift: IndexPath for last row in section.
    ///
    /// - Parameter section: section to get last row in.
    /// - Returns: optional last indexPath for last row in section (if applicable).
    func indexPathForLastRow(inSection section: Int) -> IndexPath? {
        guard numberOfSections > 0, section >= 0 else { return nil }
        guard numberOfRows(inSection: section) > 0 else {
            return IndexPath(row: 0, section: section)
        }
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }
}

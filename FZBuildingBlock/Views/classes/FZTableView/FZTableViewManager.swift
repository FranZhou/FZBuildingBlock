//
//  FZTableViewManager.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/2.
//

import Foundation

open class FZTableViewManager: NSObject {

    open var tableViewSections: [FZTableViewSection]?

    open func updateManager(withData data: [FZTableViewSection]?) {
        self.tableViewSections = data
    }
}

// MARK: UITableViewDelegate
extension FZTableViewManager: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = CGFloat.leastNormalMagnitude
        let section = indexPath.section
        let row = indexPath.row

        if let tableSection = tableViewSections?[fz_safe: section],
            let tableRow = tableSection.sectionRows?[fz_safe: row] {
            if let cellHeight = tableRow.cellHeightClosure?(tableView, indexPath) {
                height = cellHeight
            }
        }

        return height
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height = CGFloat.leastNormalMagnitude

        if let tableSection = tableViewSections?[fz_safe: section] {
            if let sectionHeaderHeight = tableSection.sectionHeaderHeightClosure?(tableView, section) {
                height = sectionHeaderHeight
            }
        }

        return height
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let tableSection = tableViewSections?[fz_safe: section],
            let sectionHeaderViewClosure = tableSection.sectionHeaderViewClosure {
            return sectionHeaderViewClosure(tableView, section)
        }
        return nil
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        var height = CGFloat.leastNormalMagnitude

        if let tableSection = tableViewSections?[fz_safe: section] {
            if let sectionFooterHeight = tableSection.sectionFooterHeightClosure?(tableView, section) {
                height = sectionFooterHeight
            }
        }

        return height
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let tableSection = tableViewSections?[fz_safe: section],
            let sectionFooterViewClosure = tableSection.sectionFooterViewClosure {
            return sectionFooterViewClosure(tableView, section)
        }
        return nil
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let tableSection = tableViewSections?[fz_safe: indexPath.section],
            let tableRow = tableSection.sectionRows?[fz_safe: indexPath.row] {
            tableRow.cellDidSelectClosure?(tableView, indexPath)
        }
    }
}

// MARK: UITableViewDataSource
extension FZTableViewManager: UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewSections?.count ?? 0
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableSection = tableViewSections?[fz_safe: section] {
            return tableSection.sectionRows?.count ?? 0
        }
        return 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?

        if let tableSection = tableViewSections?[fz_safe: indexPath.section],
            let tableRow = tableSection.sectionRows?[fz_safe: indexPath.row] {

            // get or create cell
            cell = tableView.dequeueReusableCell(withIdentifier: tableRow.identifier ?? "")
            if cell == nil {
                if let cellClassName = tableRow.cellClassName,
                    let clz = NSClassFromString(cellClassName),
                    clz is UITableViewCell.Type {
                    cell = (clz as! UITableViewCell.Type).init(style: .default, reuseIdentifier: tableRow.identifier ?? "")
                } else {
                    if (FZTableViewCell.classForCoder() is UITableViewCell.Type) {
                        cell = (FZTableViewCell.classForCoder() as! UITableViewCell.Type).init(style: .default, reuseIdentifier: tableRow.identifier ?? "")
                    }
                }
            }

            // cell
            if let cell = cell {
                // handler FZTableViewCell
                if cell.isKind(of: FZTableViewCell.classForCoder()) {
                    (cell as! FZTableViewCell).updateCell(withData: tableRow.cellData, atIndexPath: indexPath)
                }

                // handelr all cell
                if let cellHandlerClosure = tableRow.cellHandlerClosure {
                    cellHandlerClosure(tableView, cell, indexPath)
                }
            }
        }

        return cell ?? UITableViewCell()
    }

}

//
//  FZTableView.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/2.
//

import UIKit

@objc open class FZTableView: UITableView {

    open var tableViewManager: FZTableViewManager?

    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        self.defaultConfig()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - default config
extension FZTableView {

    @objc open func defaultConfig() {

        self.separatorStyle = .none

    }

    /// 配合tableViewManager使用，渲染tableview
    ///
    /// - Parameter data: FZTableViewSection array
    @objc open func updateTableViewManager(withData data: FZTableViewSectionAndRowData? = nil) {

        if let manager = tableViewManager {
            if let delegate = self.delegate,
                let dataSource = self.dataSource,
                delegate === manager && dataSource === manager {
                // manager是当前tableview的delegate和dataSource
            } else {
                self.delegate = manager
                self.dataSource = manager
            }
        }

        DispatchQueue.main.async { [weak self] in
            self?.tableViewManager?.tableSectionsAndRowsData = data
            self?.reloadData()
        }
    }
}

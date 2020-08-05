//
//  FZTableViewSectionAndRowDataAfteriOS11.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/7/30.
//

import UIKit

@available(iOS 11.0, *)
open class FZTableViewSectionAndRowDataAfteriOS11: FZTableViewSectionAndRowDataAfteriOS9 {

    // MARK: - dataSource

    // MARK: - common dataSource

    // MARK: common section dataSource

    // MARK: common row dataSource

    // MARK: - delegate

    // MARK: - common delegate

    // MARK: common section delegate

    // MARK: common row delegate

    /// optional func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    @objc open var cellLeadingSwipeActionsConfiguration: FZTableViewRowDataAfteriOS11.CellSwipeActionsConfigurationClosure?

    /// optional func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    @objc open var cellTrailingSwipeActionsConfiguration: FZTableViewRowDataAfteriOS11.CellSwipeActionsConfigurationClosure?

    /// optional func tableView(_ tableView: UITableView, shouldSpringLoadRowAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool
    @objc open var cellShouldSpringLoad: FZTableViewRowDataAfteriOS11.CellShouldSpringLoadClosure?

}

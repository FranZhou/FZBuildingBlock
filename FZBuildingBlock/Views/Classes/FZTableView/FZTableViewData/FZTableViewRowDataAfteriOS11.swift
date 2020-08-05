//
//  FZTableViewRowDataAfteriOS11.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/7/30.
//

import UIKit

@available(iOS 11.0, *)
open class FZTableViewRowDataAfteriOS11: FZTableViewRowDataAfteriOS9 {
    
    public typealias CellSwipeActionsConfigurationClosure = (_ tableView: UITableView, _ IndexPath: IndexPath) -> UISwipeActionsConfiguration?
    
    public typealias CellShouldSpringLoadClosure = (_ tableView: UITableView, _ indexPath: IndexPath, _ context: UISpringLoadedInteractionContext) -> Bool

    
    //MARK: - dataSource
    
    //MARK: - delegate
    
    /// optional func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    @objc open var cellLeadingSwipeActionsConfiguration: CellSwipeActionsConfigurationClosure?
    
    /// optional func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    @objc open var cellTrailingSwipeActionsConfiguration: CellSwipeActionsConfigurationClosure?
    
    /// optional func tableView(_ tableView: UITableView, shouldSpringLoadRowAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool
    @objc open var cellShouldSpringLoad: CellShouldSpringLoadClosure?
    
}

//
//  FZTableViewRowDataAfteriOS13.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/7/30.
//

import UIKit

@available(iOS 13.0, *)
open class FZTableViewRowDataAfteriOS13: FZTableViewRowDataAfteriOS11 {
    
    
    public typealias CellShouldBeginMultipleSelectionInteractionClosure = TableViewIndexPathBoolClosure
    
    public typealias CellDidBeginMultipleSelectionInteractionClosure = TableViewIndexPathVoidClosure
    
    public typealias CellContextMenuConfigurationClosure = (_ tableView: UITableView, _ indexPath: IndexPath, _ point: CGPoint) -> UIContextMenuConfiguration?
    
    //MARK: - dataSource
    

    //MARK: - delegate
    
    /// optional func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool
    @objc open var cellShouldBeginMultipleSelectionInteraction: CellShouldBeginMultipleSelectionInteractionClosure?
    
    /// optional func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath)
    @objc open var cellDidBeginMultipleSelectionInteraction: CellDidBeginMultipleSelectionInteractionClosure?
    
    /// optional func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration?
    @objc open var cellContextMenuConfiguration: CellContextMenuConfigurationClosure?
    
}

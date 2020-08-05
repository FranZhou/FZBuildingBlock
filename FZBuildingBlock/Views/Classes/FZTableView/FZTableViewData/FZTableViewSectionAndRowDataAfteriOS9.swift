//
//  FZTableViewSectionAndRowDataAfteriOS9.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/7/30.
//

import UIKit

@available(iOS 9.0, *)
open class FZTableViewSectionAndRowDataAfteriOS9: FZTableViewSectionAndRowData {
    
    public typealias TableViewShouldUpdateFocusClosure = (_ tableView: UITableView, _ context: UITableViewFocusUpdateContext) -> Bool
    
    public typealias TableViewDidUpdateFocusClosure = (_ tableView: UITableView, _ context: UITableViewFocusUpdateContext, _ coordinator: UIFocusAnimationCoordinator) -> Void
    
    public typealias TableViewIndexPathForPreferredFocusedViewClosure = (_ tableView: UITableView) -> IndexPath?

    //MARK: - dataSource
    
    
    // MARK: - common dataSource
    
    // MARK: common section dataSource
    
    
    // MARK: common row dataSource
    
    
    
    //MARK: - delegate
    
    /// optional func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool
    @objc open var tableViewShouldUpdateFocus: TableViewShouldUpdateFocusClosure?
    
    /// optional func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator)
    @objc open var tableViewDidUpdateFocus: TableViewDidUpdateFocusClosure?
    
    /// optional func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath?
    @objc open var tableViewIndexPathForPreferredFocusedView: TableViewIndexPathForPreferredFocusedViewClosure?
    
    
    
    // MARK: - common delegate
    
    // MARK: common section delegate
    
    
    // MARK: common row delegate
    
    /// optional func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool
    @objc open var cellCanFocus: FZTableViewRowDataAfteriOS9.CellCanFocusClosure?
    
}

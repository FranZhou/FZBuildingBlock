//
//  FZTableViewRow.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/1.
//

import Foundation

open class FZTableViewRow{
    
    /// cell data
    open var rowData: Any? = nil
    
    /// cell identifier
    open var identifier: String? = nil
    
    /// cell class name
    open var cellClassName: String? = nil
    
    /// didSelectRowAt
    open var cellDidSelectBlock: ((_ tableView: UITableView, _ indexPath: IndexPath) -> Void)?
    
    /// cell height
    open var cellHeightBlock: ((_ tableView: UITableView, _ indexPath: IndexPath) -> CGFloat)?
    
    /// cellForRowAt，called after cell has been dequeue
    open var cellHandlerBlock: ((_ tableView: UITableView, _ cell: UITableViewCell, _ indexPath: IndexPath) -> Void)?
}

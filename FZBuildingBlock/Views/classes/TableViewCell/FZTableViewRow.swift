//
//  FZTableViewRow.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/1.
//

import Foundation

open class FZTableViewRow{
    
    public typealias CellDidSelectBlock = (_ tableView: UITableView, _ indexPath: IndexPath) -> Void
    
    public typealias CellHeightBlock = (_ tableView: UITableView, _ indexPath: IndexPath) -> CGFloat
    
    public typealias CellHandlerBlock = (_ tableView: UITableView, _ cell: UITableViewCell, _ indexPath: IndexPath) -> Void
    
    public init() {
        
    }
    
    /// cell data
    open var cellData: Any? = nil
    
    /// cell identifier
    open var identifier: String? = nil
    
    /// cell class name
    open var cellClassName: String? = nil
    
    /// didSelectRowAt
    open var cellDidSelectBlock: CellDidSelectBlock?
    
    /// cell height
    open var cellHeightBlock: CellHeightBlock?
    
    /// cellForRowAt，called after cell has been dequeue
    open var cellHandlerBlock: CellHandlerBlock?
}

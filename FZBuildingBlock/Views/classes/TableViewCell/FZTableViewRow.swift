//
//  FZTableViewRow.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/1.
//

import Foundation

@objc open class FZTableViewRow: NSObject{
    
    public typealias CellDidSelectBlock = (_ tableView: UITableView, _ indexPath: IndexPath) -> Void
    
    public typealias CellHeightBlock = (_ tableView: UITableView, _ indexPath: IndexPath) -> CGFloat
    
    public typealias CellHandlerBlock = (_ tableView: UITableView, _ cell: UITableViewCell, _ indexPath: IndexPath) -> Void
    
    public override init() {
        
    }
    
    /// cell data
    @objc open var cellData: Any? = nil
    
    /// cell identifier
    @objc open var identifier: String? = nil
    
    /// cell class name
    @objc open var cellClassName: String? = nil
    
    /// didSelectRowAt
    @objc open var cellDidSelectBlock: CellDidSelectBlock?
    
    /// cell height
    @objc open var cellHeightBlock: CellHeightBlock?
    
    /// cellForRowAt，called after cell has been dequeue
    @objc open var cellHandlerBlock: CellHandlerBlock?
}

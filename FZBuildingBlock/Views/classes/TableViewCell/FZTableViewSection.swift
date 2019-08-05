//
//  FZTableViewSection.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/1.
//

import Foundation

open class FZTableViewSection{
    
    public init() {
        
    }
    
    /// section rows
    open var sectionRows: [FZTableViewRow]?
    
    /// section header height
    open var sectionHeaderHeightBlock: ((_ tableView: UITableView, _ section: Int) -> CGFloat)?
    
    /// section header View
    open var sectionHeaderViewBlock: ((_ tableView: UITableView, _ section: Int) -> UIView?)?
    
    /// section footer height
    open var sectionFooterHeightBlock: ((_ tableView: UITableView, _ section: Int) -> CGFloat)?
    
    /// section footer View
    open var sectionFooterViewBlock: ((_ tableView: UITableView, _ section: Int) -> UIView?)?
    
}

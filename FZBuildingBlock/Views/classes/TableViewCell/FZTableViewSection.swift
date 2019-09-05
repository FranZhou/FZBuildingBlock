//
//  FZTableViewSection.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/1.
//

import Foundation

@objc open class FZTableViewSection: NSObject{
    
    public override init() {
        
    }
    
    /// section rows
    @objc open var sectionRows: [FZTableViewRow]?
    
    /// section header height
    @objc open var sectionHeaderHeightBlock: ((_ tableView: UITableView, _ section: Int) -> CGFloat)?
    
    /// section header View
    @objc open var sectionHeaderViewBlock: ((_ tableView: UITableView, _ section: Int) -> UIView?)?
    
    /// section footer height
    @objc open var sectionFooterHeightBlock: ((_ tableView: UITableView, _ section: Int) -> CGFloat)?
    
    /// section footer View
    @objc open var sectionFooterViewBlock: ((_ tableView: UITableView, _ section: Int) -> UIView?)?
    
}

//
//  FZTableView.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/2.
//

import UIKit

open class FZTableView: UITableView {
    
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
extension FZTableView{
    
    open func defaultConfig(){
        
        self.separatorStyle = .none
        
        if #available(iOS 11.0, *){
            self.estimatedRowHeight = 0
            self.estimatedSectionHeaderHeight = 0
            self.estimatedSectionFooterHeight = 0
            self.contentInsetAdjustmentBehavior = .never
        }
        
    }
    
    
    /// 配合tableViewManager使用，渲染tableview
    ///
    /// - Parameter data: FZTableViewSection array
    open func updateTableView(withData data: [FZTableViewSection]? = nil){
        
        if let manager = tableViewManager {
            self.delegate = manager
            self.dataSource = manager
        }
        
        tableViewManager?.updateManager(withData: data)
        super.reloadData()
    }
}


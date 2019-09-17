//
//  FZTableViewSection.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/1.
//

import Foundation

@objc open class FZTableViewSection: NSObject {

    public override init() {

    }

    /// section rows
    @objc open var sectionRows: [FZTableViewRow]?

    /// section header height
    @objc open var sectionHeaderHeightClosure: ((_ tableView: UITableView, _ section: Int) -> CGFloat)?

    /// section header View
    @objc open var sectionHeaderViewClosure: ((_ tableView: UITableView, _ section: Int) -> UIView?)?

    /// section footer height
    @objc open var sectionFooterHeightClosure: ((_ tableView: UITableView, _ section: Int) -> CGFloat)?

    /// section footer View
    @objc open var sectionFooterViewClosure: ((_ tableView: UITableView, _ section: Int) -> UIView?)?

}

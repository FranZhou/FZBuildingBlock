//
//  FZTableViewRow.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/1.
//

import Foundation

@objc open class FZTableViewRow: NSObject {

    public typealias CellDidSelectClosure = (_ tableView: UITableView, _ indexPath: IndexPath) -> Void

    public typealias CellHeightClosure = (_ tableView: UITableView, _ indexPath: IndexPath) -> CGFloat

    public typealias CellHandlerClosure = (_ tableView: UITableView, _ cell: UITableViewCell, _ indexPath: IndexPath) -> Void

    public override init() {

    }

    /// cell data
    @objc open var cellData: Any?

    /// cell identifier
    @objc open var identifier: String?

    /// cell class name
    @objc open var cellClassName: String?

    /// didSelectRowAt
    @objc open var cellDidSelectClosure: CellDidSelectClosure?

    /// cell height
    @objc open var cellHeightClosure: CellHeightClosure?

    /// cellForRowAt，called after cell has been dequeue
    @objc open var cellHandlerClosure: CellHandlerClosure?
}

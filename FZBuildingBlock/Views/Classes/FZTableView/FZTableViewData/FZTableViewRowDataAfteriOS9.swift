//
//  FZTableViewRowDataAfteriOS9.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/7/30.
//

import UIKit

@available(iOS 9.0, *)
open class FZTableViewRowDataAfteriOS9: FZTableViewRowData {

    public typealias CellCanFocusClosure = TableViewIndexPathBoolClosure

    // MARK: - dataSource

    // MARK: - delegate

    /// optional func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool
    @objc open var cellCanFocus: CellCanFocusClosure?

}

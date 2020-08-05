//
//  TableViewCommonRowData.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2020/8/5.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import FZBuildingBlock

class TableViewCommonRowData: FZTableViewRowData {

    /// cell data
    @objc open var cellData: Any?

    /// cell identifier
    @objc open var identifier: String?

    /// cell class name
    @objc open var cellClassName: String?

}

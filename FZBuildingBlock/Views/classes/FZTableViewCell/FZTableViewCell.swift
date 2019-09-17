//
//  FZTableViewCell.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/7/31.
//

import UIKit

open class FZTableViewCell: UITableViewCell {

    // MARK: -
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: - override
@objc
extension FZTableViewCell {

    /// cell reuseIdentifier
    ///
    /// - Returns: reuseIdentifier, default = className String
    open class func reuseIdentifier() -> String {
        return NSStringFromClass(self.classForCoder())
    }

    /// update cell UI
    /// 子类继承并且实现自定义处理方式，FZTableViewManager会进行调用
    ///
    /// - Parameters:
    ///   - data: cell data, default = nil
    ///   - indexPath: indexPath, default = nil
    open func updateCell(withData data: Any? = nil, atIndexPath indexPath: IndexPath? = nil) {

    }
}

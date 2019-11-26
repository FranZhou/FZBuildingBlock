//
//  FZContainerViewModel.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/6.
//

import Foundation

@objc open class FZContainerViewModel: NSObject {

    public typealias FZContainerItemViewClosure = (_ itemView: UIView, _ containerView: UIView) -> Void

    /// itemView
    @objc public var itemView: UIView?

    /// after itemView added to FZContainerView
    /// execute itemBlock to make constraints or whatever
    @objc public var itemClosure: FZContainerItemViewClosure?
}

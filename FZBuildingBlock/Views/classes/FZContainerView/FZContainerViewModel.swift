//
//  FZContainerViewModel.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/6.
//

import Foundation


@objc open class FZContainerViewModel: NSObject{
    
    public typealias FZContainerItemViewBlock = (_ itemView: UIView, _ containerView: UIView) -> Void
    
    /// itemView
    @objc public var itemView: UIView?
    
    /// after itemView added to FZContainerView
    /// execute itemBlock to make constraints or whatever
    @objc public var itemBlock: FZContainerItemViewBlock?
}

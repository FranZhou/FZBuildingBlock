//
//  UIBarButtonItem+Closures.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/18.
//

import Foundation

extension UIBarButtonItem.fz {

    public static func barButtonItem(barButtonSystemItem systemItem: UIBarButtonItem.SystemItem, closure: FZUIBarButtonItemClosureHandler.FZUIBarButtonItemClosure?) -> UIBarButtonItem {

        let barButtonItem = UIBarButtonItem(barButtonSystemItem: systemItem, target: nil, action: nil)

        let handler = FZUIBarButtonItemClosureHandler(closure: closure, sender: barButtonItem)

        barButtonItem.target = handler
        barButtonItem.action = #selector(handler.handle)

        barButtonItem.fz.barButtonItemHandler = handler

        return barButtonItem
    }

    public static func barButtonItem(image: UIImage?, landscapeImagePhone: UIImage?, style: UIBarButtonItem.Style, closure: FZUIBarButtonItemClosureHandler.FZUIBarButtonItemClosure?) -> UIBarButtonItem {

        let barButtonItem = UIBarButtonItem(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: nil, action: nil)

        let handler = FZUIBarButtonItemClosureHandler(closure: closure, sender: barButtonItem)

        barButtonItem.target = handler
        barButtonItem.action = #selector(handler.handle)

        barButtonItem.fz.barButtonItemHandler = handler

        return barButtonItem
    }

    public static func barButtonItem(image: UIImage?, style: UIBarButtonItem.Style, closure: FZUIBarButtonItemClosureHandler.FZUIBarButtonItemClosure?) -> UIBarButtonItem {

        let barButtonItem = UIBarButtonItem(image: image, style: style, target: nil, action: nil)

        let handler = FZUIBarButtonItemClosureHandler(closure: closure, sender: barButtonItem)

        barButtonItem.target = handler
        barButtonItem.action = #selector(handler.handle)

        barButtonItem.fz.barButtonItemHandler = handler

        return barButtonItem
    }

}

//
//  FZContainerView.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/6.
//

import Foundation

open class FZContainerView: UIView {

    @objc public var containerViewModels: [FZContainerViewModel]?

    /// update self with FZContainerViewModel array
    ///
    /// - Parameter models: FZContainerViewModel array
    @objc public func update(withContainerViewModels models: [FZContainerViewModel]) {
        self.containerViewModels = models

        // remove view and view's constraint
        for (_, view) in subviews.enumerated() {
            for (_, constraint) in view.constraints.enumerated() {

                // remove view's constraint
                if let firstItem = constraint.firstItem as? UIView,
                    firstItem == view {
                    self.removeConstraint(constraint)
                } else if let secondItem = constraint.secondItem as? UIView,
                    secondItem == view {
                    self.removeConstraint(constraint)
                }
            }

            // remove view
            view.removeFromSuperview()
        }

        // add itemView
        for model in models {
            if let view = model.itemView {
                self.addSubview(view)
            }
        }

        // execute itemBlock
        for model in models {
            if let view = model.itemView,
                let closure = model.itemClosure {
                closure(view, self)
            }
        }

    }

}

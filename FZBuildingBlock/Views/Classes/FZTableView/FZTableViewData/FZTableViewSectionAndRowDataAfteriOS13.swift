//
//  FZTableViewSectionAndRowDataAfteriOS13.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/7/30.
//

import UIKit

@available(iOS 13.0, *)
class FZTableViewSectionAndRowDataAfteriOS13: FZTableViewSectionAndRowDataAfteriOS11 {

    public typealias TableViewConfigurationPreviewClosure = (_ tableView: UITableView, _ configuration: UIContextMenuConfiguration) -> UITargetedPreview?

    // MARK: - closure

    public typealias TableViewDidEndMultipleSelectionInteractionClosure = (_ tableView: UITableView) -> Void

    public typealias TableViewPreviewForHighlightingContextMenuWithConfigurationClosure = TableViewConfigurationPreviewClosure

    public typealias TableViewPreviewForDismissingContextMenuWithConfigurationClosure = TableViewConfigurationPreviewClosure

    public typealias TableViewWillPerformPreviewActionForMenuConfigurationClosure = (_ tableView: UITableView, _ configuration: UIContextMenuConfiguration, _ animator: UIContextMenuInteractionCommitAnimating) -> Void

    // MARK: - dataSource

    // MARK: - common dataSource

    // MARK: common section dataSource

    // MARK: common row dataSource

    // MARK: - delegate

    /// optional func tableViewDidEndMultipleSelectionInteraction(_ tableView: UITableView)
    @objc open var tableViewDidEndMultipleSelectionInteraction: TableViewDidEndMultipleSelectionInteractionClosure?

    @discardableResult
    open func setTableViewDidEndMultipleSelectionInteraction(_ block: TableViewDidEndMultipleSelectionInteractionClosure?) -> Self {
        tableViewDidEndMultipleSelectionInteraction = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview?
    @objc open var tableViewPreviewForHighlightingContextMenuWithConfiguration: TableViewPreviewForHighlightingContextMenuWithConfigurationClosure?

    @discardableResult
    open func setTableViewPreviewForHighlightingContextMenuWithConfiguration(_ block: TableViewPreviewForHighlightingContextMenuWithConfigurationClosure?) -> Self {
        tableViewPreviewForHighlightingContextMenuWithConfiguration = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview?
    @objc open var tableViewPreviewForDismissingContextMenuWithConfiguration: TableViewPreviewForDismissingContextMenuWithConfigurationClosure?

    @discardableResult
    open func setTableViewPreviewForDismissingContextMenuWithConfiguration(_ block: TableViewPreviewForDismissingContextMenuWithConfigurationClosure?) -> Self {
        tableViewPreviewForDismissingContextMenuWithConfiguration = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating)
    @objc open var tableViewWillPerformPreviewActionForMenuConfiguration: TableViewWillPerformPreviewActionForMenuConfigurationClosure?

    @discardableResult
    open func setTableViewWillPerformPreviewActionForMenuConfiguration(_ block: TableViewWillPerformPreviewActionForMenuConfigurationClosure?) -> Self {
        tableViewWillPerformPreviewActionForMenuConfiguration = block
        return self
    }

    // MARK: - common delegate

    // MARK: common section delegate

    // MARK: common row delegate

    /// optional func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool
    @objc open var cellShouldBeginMultipleSelectionInteraction: FZTableViewRowDataAfteriOS13.CellShouldBeginMultipleSelectionInteractionClosure?

    @discardableResult
    open func setCellShouldBeginMultipleSelectionInteraction(_ block: FZTableViewRowDataAfteriOS13.CellShouldBeginMultipleSelectionInteractionClosure?) -> Self {
        cellShouldBeginMultipleSelectionInteraction = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath)
    @objc open var cellDidBeginMultipleSelectionInteraction: FZTableViewRowDataAfteriOS13.CellDidBeginMultipleSelectionInteractionClosure?

    @discardableResult
    open func setCellDidBeginMultipleSelectionInteraction(_ block: FZTableViewRowDataAfteriOS13.CellDidBeginMultipleSelectionInteractionClosure?) -> Self {
        cellDidBeginMultipleSelectionInteraction = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration?
    @objc open var cellContextMenuConfiguration: FZTableViewRowDataAfteriOS13.CellContextMenuConfigurationClosure?

    @discardableResult
    open func setCellContextMenuConfiguration(_ block: FZTableViewRowDataAfteriOS13.CellContextMenuConfigurationClosure?) -> Self {
        cellContextMenuConfiguration = block
        return self
    }

}

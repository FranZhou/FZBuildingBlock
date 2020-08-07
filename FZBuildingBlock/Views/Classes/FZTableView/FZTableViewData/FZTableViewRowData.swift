//
//  FZTableViewRowData.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/7/29.
//

import Foundation

@objc open class FZTableViewRowData: NSObject {

    // MARK: - tableView closure

    public typealias TableViewIndexPathBoolClosure = (_ tableView: UITableView, _ indexPath: IndexPath) -> Bool

    public typealias TableViewIndexPathFloatClosure = (_ tableView: UITableView, _ indexPath: IndexPath) -> CGFloat

    public typealias TableViewIndexPathVoidClosure = (_ tableView: UITableView, _ indexPath: IndexPath) -> Void

    public typealias TableViewCellIndexPathVoidClosure = (_ tableView: UITableView, _ cell: UITableViewCell, _ IndexPath: IndexPath) -> Void

    public typealias TableViewIndexPathIndexPathClosure = (_ tableView: UITableView, _ indexPath: IndexPath) -> IndexPath?

    // MARK: - cell closure

    public typealias CellClosure = (_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell

    public typealias CellCanEditClosure = TableViewIndexPathBoolClosure

    public typealias CellCanMoveClosure = TableViewIndexPathBoolClosure

    public typealias CellCommitEditingStyleClosure = (_ tableView: UITableView, _ editingStyle: UITableViewCell.EditingStyle, _ IndexPath: IndexPath) -> Void

    public typealias CellWillDisplayClosure = TableViewCellIndexPathVoidClosure

    public typealias CelldidEndDisplayingClosure = TableViewCellIndexPathVoidClosure

    public typealias CellHeightClosure = TableViewIndexPathFloatClosure

    public typealias CellEstimatedHeightClosure = TableViewIndexPathFloatClosure

    public typealias CellAccessoryButtonTappedClosure = TableViewIndexPathVoidClosure

    public typealias CellShouldHighlightClosure = TableViewIndexPathBoolClosure

    public typealias CellDidHighlightClosure = TableViewIndexPathVoidClosure

    public typealias CellDidUnhighlightClosure = TableViewIndexPathVoidClosure

    public typealias CellWillSelectClosure = TableViewIndexPathIndexPathClosure

    public typealias CellWillDeselectClosure = TableViewIndexPathIndexPathClosure

    public typealias CellDidSelectClosure = TableViewIndexPathVoidClosure

    public typealias CellDidDeselectClosure = TableViewIndexPathVoidClosure

    public typealias CellEditingStyleClosure = (_ tableView: UITableView, _ IndexPath: IndexPath) -> UITableViewCell.EditingStyle

    public typealias CellTitleForDeleteConfirmationButtonClosure = (_ tableView: UITableView, _ IndexPath: IndexPath) -> String?

    public typealias CellEditActionsClosure = (_ tableView: UITableView, _ IndexPath: IndexPath) -> [UITableViewRowAction]?

    public typealias CellShouldIndentWhileEditingClosure = TableViewIndexPathBoolClosure

    public typealias CellWillBeginEditingClosure = TableViewIndexPathVoidClosure

    public typealias CellDidEndEditingClosure = TableViewIndexPathVoidClosure

    public typealias CellIndentationLevelClosure = (_ tableView: UITableView, _ indexPath: IndexPath) -> Int

    public typealias CellShouldShowMenuClosure = TableViewIndexPathBoolClosure

    public typealias CellCanPerformActionClosure = (_ tableView: UITableView, _ action: Selector, _ indexPath: IndexPath, _ sender: Any?) -> Bool

    public typealias CellPerformActionClosure = (_ tableView: UITableView, _ action: Selector, _ indexPath: IndexPath, _ sender: Any?) -> Void

    public override init() {

    }

    // MARK: - dataSource

    /// func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    @objc open var cell: CellClosure?

    @discardableResult
    open func setCell(_ block: CellClosure?) -> Self {
        cell = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    @objc open var cellCanEdit: CellCanEditClosure?

    @discardableResult
    open func setCellCanEdit(_ block: CellCanEditClosure?) -> Self {
        cellCanEdit = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    @objc open var cellCanMove: CellCanMoveClosure?

    @discardableResult
    open func setCellCanMove(_ block: CellCanMoveClosure?) -> Self {
        cellCanMove = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    @objc open var cellCommitEditingStyle: CellCommitEditingStyleClosure?

    @discardableResult
    open func setCellCommitEditingStyle(_ block: CellCommitEditingStyleClosure?) -> Self {
        cellCommitEditingStyle = block
        return self
    }

    // MARK: - delegate

    /// optional func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    @objc open var cellWillDisplay: CellWillDisplayClosure?

    @discardableResult
    open func setCellWillDisplay(_ block: CellWillDisplayClosure?) -> Self {
        cellWillDisplay = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
    @objc open var celldidEndDisplaying: CelldidEndDisplayingClosure?

    @discardableResult
    open func setCelldidEndDisplaying(_ block: CelldidEndDisplayingClosure?) -> Self {
        celldidEndDisplaying = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    @objc open var cellHeight: CellHeightClosure?

    @discardableResult
    open func setCellHeight(_ block: CellHeightClosure?) -> Self {
        cellHeight = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    @objc open var cellEstimatedHeight: CellEstimatedHeightClosure?

    @discardableResult
    open func setCellEstimatedHeight(_ block: CellEstimatedHeightClosure?) -> Self {
        cellEstimatedHeight = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath)
    @objc open var cellAccessoryButtonTapped: CellAccessoryButtonTappedClosure?

    @discardableResult
    open func setCellAccessoryButtonTapped(_ block: CellAccessoryButtonTappedClosure?) -> Self {
        cellAccessoryButtonTapped = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
    @objc open var cellShouldHighlight: CellShouldHighlightClosure?

    @discardableResult
    open func setCellShouldHighlight(_ block: CellShouldHighlightClosure?) -> Self {
        cellShouldHighlight = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath)
    @objc open var cellDidHighlight: CellDidHighlightClosure?

    @discardableResult
    open func setCellDidHighlight(_ block: CellDidHighlightClosure?) -> Self {
        cellDidHighlight = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath)
    @objc open var cellDidUnhighlight: CellDidUnhighlightClosure?

    @discardableResult
    open func setCellDidUnhighlight(_ block: CellDidUnhighlightClosure?) -> Self {
        cellDidUnhighlight = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
    @objc open var cellWillSelect: CellWillSelectClosure?

    @discardableResult
    open func setCellWillSelect(_ block: CellWillSelectClosure?) -> Self {
        cellWillSelect = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath?
    @objc open var cellWillDeselect: CellWillDeselectClosure?

    @discardableResult
    open func setCellWillDeselect(_ block: CellWillDeselectClosure?) -> Self {
        cellWillDeselect = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    @objc open var cellDidSelect: CellDidSelectClosure?

    @discardableResult
    open func setCellDidSelect(_ block: CellDidSelectClosure?) -> Self {
        cellDidSelect = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    @objc open var cellDidDeselect: CellDidDeselectClosure?

    @discardableResult
    open func setCellDidDeselect(_ block: CellDidDeselectClosure?) -> Self {
        cellDidDeselect = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    @objc open var cellEditingStyle: CellEditingStyleClosure?

    @discardableResult
    open func setCellEditingStyle(_ block: CellEditingStyleClosure?) -> Self {
        cellEditingStyle = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
    @objc open var cellTitleForDeleteConfirmationButton: CellTitleForDeleteConfirmationButtonClosure?

    @discardableResult
    open func setCellTitleForDeleteConfirmationButton(_ block: CellTitleForDeleteConfirmationButtonClosure?) -> Self {
        cellTitleForDeleteConfirmationButton = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    @objc open var cellEditActions: CellEditActionsClosure?

    @discardableResult
    open func setCellEditActions(_ block: CellEditActionsClosure?) -> Self {
        cellEditActions = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool
    @objc open var cellShouldIndentWhileEditing: CellShouldIndentWhileEditingClosure?

    @discardableResult
    open func setCellShouldIndentWhileEditing(_ block: CellShouldIndentWhileEditingClosure?) -> Self {
        cellShouldIndentWhileEditing = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath)
    @objc open var cellWillBeginEditing: CellWillBeginEditingClosure?

    @discardableResult
    open func setCellWillBeginEditing(_ block: CellWillBeginEditingClosure?) -> Self {
        cellWillBeginEditing = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?)
    @objc open var cellDidEndEditing: CellDidEndEditingClosure?

    @discardableResult
    open func setCellDidEndEditing(_ block: CellDidEndEditingClosure?) -> Self {
        cellDidEndEditing = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int
    @objc open var cellIndentationLevel: CellIndentationLevelClosure?

    @discardableResult
    open func setCellIndentationLevel(_ block: CellIndentationLevelClosure?) -> Self {
        cellIndentationLevel = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool
    @objc open var cellShouldShowMenu: CellShouldShowMenuClosure?

    @discardableResult
    open func setCellShouldShowMenu(_ block: CellShouldShowMenuClosure?) -> Self {
        cellShouldShowMenu = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool
    @objc open var cellCanPerformAction: CellCanPerformActionClosure?

    @discardableResult
    open func setCellCanPerformAction(_ block: CellCanPerformActionClosure?) -> Self {
        cellCanPerformAction = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?)
    @objc open var cellPerformAction: CellPerformActionClosure?

    @discardableResult
    open func setCellPerformAction(_ block: CellPerformActionClosure?) -> Self {
        cellPerformAction = block
        return self
    }

}

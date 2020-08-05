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

    public typealias CellDequeueClosure = (_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell

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
    @objc open var cellDequeue: CellDequeueClosure?

    /// optional func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    @objc open var cellCanEdit: CellCanEditClosure?

    /// optional func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    @objc open var cellCanMove: CellCanMoveClosure?

    /// optional func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    @objc open var cellCommitEditingStyle: CellCommitEditingStyleClosure?

    // MARK: - delegate

    /// optional func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    @objc open var cellWillDisplay: CellWillDisplayClosure?

    /// optional func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
    @objc open var celldidEndDisplaying: CelldidEndDisplayingClosure?

    /// optional func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    @objc open var cellHeight: CellHeightClosure?

    /// optional func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    @objc open var cellEstimatedHeight: CellEstimatedHeightClosure?

    /// optional func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath)
    @objc open var cellAccessoryButtonTapped: CellAccessoryButtonTappedClosure?

    /// optional func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
    @objc open var cellShouldHighlight: CellShouldHighlightClosure?

    /// optional func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath)
    @objc open var cellDidHighlight: CellDidHighlightClosure?

    /// optional func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath)
    @objc open var cellDidUnhighlight: CellDidUnhighlightClosure?

    /// optional func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
    @objc open var cellWillSelect: CellWillSelectClosure?

    /// optional func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath?
    @objc open var cellWillDeselect: CellWillDeselectClosure?

    /// optional func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    @objc open var cellDidSelect: CellDidSelectClosure?

    /// optional func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    @objc open var cellDidDeselect: CellDidDeselectClosure?

    /// optional func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    @objc open var cellEditingStyle: CellEditingStyleClosure?

    /// optional func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
    @objc open var cellTitleForDeleteConfirmationButton: CellTitleForDeleteConfirmationButtonClosure?

    /// optional func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    @objc open var cellEditActions: CellEditActionsClosure?

    /// optional func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool
    @objc open var cellShouldIndentWhileEditing: CellShouldIndentWhileEditingClosure?

    /// optional func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath)
    @objc open var cellWillBeginEditing: CellWillBeginEditingClosure?

    /// optional func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?)
    @objc open var cellDidEndEditing: CellDidEndEditingClosure?

    /// optional func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int
    @objc open var cellIndentationLevel: CellIndentationLevelClosure?

    /// optional func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool
    @objc open var cellShouldShowMenu: CellShouldShowMenuClosure?

    /// optional func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool
    @objc open var cellCanPerformAction: CellCanPerformActionClosure?

    /// optional func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?)
    @objc open var cellPerformAction: CellPerformActionClosure?

}

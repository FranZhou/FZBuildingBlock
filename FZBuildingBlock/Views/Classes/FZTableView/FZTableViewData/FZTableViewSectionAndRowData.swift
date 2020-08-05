//
//  FZTableViewSectionAndRowData.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/7/29.
//

import UIKit

open class FZTableViewSectionAndRowData: NSObject {

    // MARK: - closure

    public typealias TableViewSectionIndexTitlesClosure = (_ tableView: UITableView) -> [String]?

    public typealias TableViewSectionForSectionIndexTitleClosure = (_ tableView: UITableView, _ title: String, _ index: Int) -> Int

    public typealias TableViewCellMoveClosure = (_ tableView: UITableView, _ indexPath: IndexPath, _ indexPath: IndexPath) -> Void

    public typealias TableViewCellTargetIndexPathForMoveClosure = (_ tableView: UITableView, _ indexPath: IndexPath, _ indexPath: IndexPath) -> IndexPath

    public typealias TableViewCellDidEndEditingClosure = (_ tableView: UITableView, _ indexPath: IndexPath?) -> Void

    // MARK: - property
    /// section rows
    @objc open var sectionDatas: [FZTableViewSectionData]?

    // MARK: - dataSource

    /// optional func sectionIndexTitles(for tableView: UITableView) -> [String]?
    @objc open var tableViewSectionIndexTitles: TableViewSectionIndexTitlesClosure?

    /// ptional func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int
    @objc open var tableViewSectionForSectionIndexTitle: TableViewSectionForSectionIndexTitleClosure?

    /// optional func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    @objc open var tableViewCellMove: TableViewCellMoveClosure?

    // MARK: - common dataSource

    // MARK: common section dataSource

    /// optional func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    @objc open var sectionHeaderTitle: FZTableViewSectionData.SectionHeadertitleClosure?

    /// optional func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    @objc open var sectionFooterTitle: FZTableViewSectionData.SectionFooterTitleClosure?

    // MARK: common row dataSource

    /// func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    @objc open var cellDequeue: FZTableViewRowData.CellDequeueClosure?

    /// optional func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    @objc open var cellCanEdit: FZTableViewRowData.CellCanEditClosure?

    /// optional func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    @objc open var cellCanMove: FZTableViewRowData.CellCanMoveClosure?

    /// optional func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    @objc open var cellCommitEditingStyle: FZTableViewRowData.CellCommitEditingStyleClosure?

    // MARK: - delegate

    /// optional func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath
    @objc open var tableViewCellTargetIndexPathForMove: TableViewCellTargetIndexPathForMoveClosure?

    // MARK: - common delegate

    // MARK: common section delegate

    /// optional func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    @objc open var sectionHeaderViewWillDisplay: FZTableViewSectionData.SectionHeaderViewWillDisplayClosure?

    /// optional func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int)
    @objc open var sectionFooterViewWillDisplay: FZTableViewSectionData.SectionFooterViewWillDisplayClosure?

    /// optional func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int)
    @objc open var sectionHeaderViewDidEndDisplay: FZTableViewSectionData.SectionHeaderViewDidEndDisplayClosure?

    /// optional func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int)
    @objc open var sectionFooterViewDidEndDisplay: FZTableViewSectionData.SectionFooterViewDidEndDisplayClosure?

    /// optional func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    @objc open var sectionHeaderViewHeight: FZTableViewSectionData.SectionHeaderViewHeightClosure?

    /// optional func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    @objc open var sectionFooterViewHeight: FZTableViewSectionData.SectionFooterViewHeightClosure?

    /// optional func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat
    @objc open var sectionHeaderViewEstimatedHeight: FZTableViewSectionData.SectionHeaderViewEstimatedHeightClosure?

    /// optional func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat
    @objc open var sectionFooterViewEstimatedHeight: FZTableViewSectionData.SectionFooterViewEstimatedHeightClosure?

    /// optional func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    @objc open var sectionHeaderView: FZTableViewSectionData.SectionHeaderViewClosure?

    /// optional func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    @objc open var sectionFooterView: FZTableViewSectionData.SectionFooterViewClosure?

    // MARK: common row delegate

    /// optional func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    @objc open var cellWillDisplay: FZTableViewRowData.CellWillDisplayClosure?

    /// optional func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
    @objc open var celldidEndDisplaying: FZTableViewRowData.CelldidEndDisplayingClosure?

    /// optional func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    @objc open var cellHeight: FZTableViewRowData.CellHeightClosure?

    /// optional func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    @objc open var cellEstimatedHeight: FZTableViewRowData.CellEstimatedHeightClosure?

    /// optional func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath)
    @objc open var cellAccessoryButtonTapped: FZTableViewRowData.CellAccessoryButtonTappedClosure?

    /// optional func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
    @objc open var cellShouldHighlight: FZTableViewRowData.CellShouldHighlightClosure?

    /// optional func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath)
    @objc open var cellDidHighlight: FZTableViewRowData.CellDidHighlightClosure?

    /// optional func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath)
    @objc open var cellDidUnhighlight: FZTableViewRowData.CellDidUnhighlightClosure?

    /// optional func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
    @objc open var cellWillSelect: FZTableViewRowData.CellWillSelectClosure?

    /// optional func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath?
    @objc open var cellWillDeselect: FZTableViewRowData.CellWillDeselectClosure?

    /// optional func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    @objc open var cellDidSelect: FZTableViewRowData.CellDidSelectClosure?

    /// optional func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    @objc open var cellDidDeselect: FZTableViewRowData.CellDidDeselectClosure?

    /// optional func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    @objc open var cellEditingStyle: FZTableViewRowData.CellEditingStyleClosure?

    /// optional func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
    @objc open var cellTitleForDeleteConfirmationButton: FZTableViewRowData.CellTitleForDeleteConfirmationButtonClosure?

    /// optional func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    @objc open var cellEditActions: FZTableViewRowData.CellEditActionsClosure?

    /// optional func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool
    @objc open var cellShouldIndentWhileEditing: FZTableViewRowData.CellShouldIndentWhileEditingClosure?

    /// optional func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath)
    @objc open var cellWillBeginEditing: FZTableViewRowData.CellWillBeginEditingClosure?

    /// optional func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?)
    @objc open var cellDidEndEditing: TableViewCellDidEndEditingClosure?

    /// optional func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int
    @objc open var cellIndentationLevel: FZTableViewRowData.CellIndentationLevelClosure?

    /// optional func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool
    @objc open var cellShouldShowMenu: FZTableViewRowData.CellShouldShowMenuClosure?

    /// optional func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool
    @objc open var cellCanPerformAction: FZTableViewRowData.CellCanPerformActionClosure?

    /// optional func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?)
    @objc open var cellPerformAction: FZTableViewRowData.CellPerformActionClosure?
}

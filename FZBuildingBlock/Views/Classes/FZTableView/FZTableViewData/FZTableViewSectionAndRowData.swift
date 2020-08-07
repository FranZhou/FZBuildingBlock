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

    @discardableResult
    open func setSectionDatas(_ sectionDatas: [FZTableViewSectionData]?) -> Self {
        self.sectionDatas = sectionDatas
        return self
    }

    // MARK: - dataSource

    /// optional func sectionIndexTitles(for tableView: UITableView) -> [String]?
    @objc open var tableViewSectionIndexTitles: TableViewSectionIndexTitlesClosure?

    @discardableResult
    open func setTableViewSectionIndexTitles(_ block: TableViewSectionIndexTitlesClosure?) -> Self {
        tableViewSectionIndexTitles = block
        return self
    }

    /// ptional func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int
    @objc open var tableViewSectionForSectionIndexTitle: TableViewSectionForSectionIndexTitleClosure?

    @discardableResult
    open func setTableViewSectionForSectionIndexTitle(_ block: TableViewSectionForSectionIndexTitleClosure?) -> Self {
        tableViewSectionForSectionIndexTitle = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    @objc open var tableViewCellMove: TableViewCellMoveClosure?

    @discardableResult
    open func setTableViewCellMove(_ block: TableViewCellMoveClosure?) -> Self {
        tableViewCellMove = block
        return self
    }

    // MARK: - common dataSource

    // MARK: common section dataSource

    /// optional func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    @objc open var sectionHeaderTitle: FZTableViewSectionData.SectionHeadertitleClosure?

    @discardableResult
    open func setSectionHeadertitle(_ block: FZTableViewSectionData.SectionHeadertitleClosure?) -> Self {
        sectionHeaderTitle = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    @objc open var sectionFooterTitle: FZTableViewSectionData.SectionFooterTitleClosure?

    @discardableResult
    open func setSectionFooterTitle(_ block: FZTableViewSectionData.SectionFooterTitleClosure?) -> Self {
        sectionFooterTitle = block
        return self
    }

    // MARK: common row dataSource

    /// func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    @objc open var cell: FZTableViewRowData.CellClosure?

    @discardableResult
    open func setCell(_ block: FZTableViewRowData.CellClosure?) -> Self {
        cell = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    @objc open var cellCanEdit: FZTableViewRowData.CellCanEditClosure?

    @discardableResult
    open func setCellCanEdit(_ block: FZTableViewRowData.CellCanEditClosure?) -> Self {
        cellCanEdit = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    @objc open var cellCanMove: FZTableViewRowData.CellCanMoveClosure?

    @discardableResult
    open func setCellCanMove(_ block: FZTableViewRowData.CellCanMoveClosure?) -> Self {
        cellCanMove = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    @objc open var cellCommitEditingStyle: FZTableViewRowData.CellCommitEditingStyleClosure?

    @discardableResult
    open func setCellCommitEditingStyle(_ block: FZTableViewRowData.CellCommitEditingStyleClosure?) -> Self {
        cellCommitEditingStyle = block
        return self
    }

    // MARK: - delegate

    /// optional func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath
    @objc open var tableViewCellTargetIndexPathForMove: TableViewCellTargetIndexPathForMoveClosure?

    @discardableResult
    open func setTableViewCellTargetIndexPathForMove(_ block: TableViewCellTargetIndexPathForMoveClosure?) -> Self {
        tableViewCellTargetIndexPathForMove = block
        return self
    }

    // MARK: - common delegate

    // MARK: common section delegate

    /// optional func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    @objc open var sectionHeaderViewWillDisplay: FZTableViewSectionData.SectionHeaderViewWillDisplayClosure?

    @discardableResult
    open func setSectionHeaderViewWillDisplay(_ block: FZTableViewSectionData.SectionHeaderViewWillDisplayClosure?) -> Self {
        sectionHeaderViewWillDisplay = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int)
    @objc open var sectionFooterViewWillDisplay: FZTableViewSectionData.SectionFooterViewWillDisplayClosure?

    @discardableResult
    open func setSectionFooterViewWillDisplay(_ block: FZTableViewSectionData.SectionFooterViewWillDisplayClosure?) -> Self {
        sectionFooterViewWillDisplay = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int)
    @objc open var sectionHeaderViewDidEndDisplay: FZTableViewSectionData.SectionHeaderViewDidEndDisplayClosure?

    @discardableResult
    open func setSectionHeaderViewDidEndDisplay(_ block: FZTableViewSectionData.SectionHeaderViewDidEndDisplayClosure?) -> Self {
        sectionHeaderViewDidEndDisplay = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int)
    @objc open var sectionFooterViewDidEndDisplay: FZTableViewSectionData.SectionFooterViewDidEndDisplayClosure?

    @discardableResult
    open func setSectionFooterViewDidEndDisplay(_ block: FZTableViewSectionData.SectionFooterViewDidEndDisplayClosure?) -> Self {
        sectionFooterViewDidEndDisplay = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    @objc open var sectionHeaderViewHeight: FZTableViewSectionData.SectionHeaderViewHeightClosure?

    @discardableResult
    open func setSectionHeaderViewHeight(_ block: FZTableViewSectionData.SectionHeaderViewHeightClosure?) -> Self {
        sectionHeaderViewHeight = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    @objc open var sectionFooterViewHeight: FZTableViewSectionData.SectionFooterViewHeightClosure?

    @discardableResult
    open func setSectionFooterViewHeight(_ block: FZTableViewSectionData.SectionFooterViewHeightClosure?) -> Self {
        sectionFooterViewHeight = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat
    @objc open var sectionHeaderViewEstimatedHeight: FZTableViewSectionData.SectionHeaderViewEstimatedHeightClosure?

    @discardableResult
    open func setSectionHeaderViewEstimatedHeight(_ block: FZTableViewSectionData.SectionHeaderViewEstimatedHeightClosure?) -> Self {
        sectionHeaderViewEstimatedHeight = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat
    @objc open var sectionFooterViewEstimatedHeight: FZTableViewSectionData.SectionFooterViewEstimatedHeightClosure?

    @discardableResult
    open func setSectionFooterViewEstimatedHeight(_ block: FZTableViewSectionData.SectionFooterViewEstimatedHeightClosure?) -> Self {
        sectionFooterViewEstimatedHeight = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    @objc open var sectionHeaderView: FZTableViewSectionData.SectionHeaderViewClosure?

    @discardableResult
    open func setSectionHeaderView(_ block: FZTableViewSectionData.SectionHeaderViewClosure?) -> Self {
        sectionHeaderView = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    @objc open var sectionFooterView: FZTableViewSectionData.SectionFooterViewClosure?

    @discardableResult
    open func setSectionFooterView(_ block: FZTableViewSectionData.SectionFooterViewClosure?) -> Self {
        sectionFooterView = block
        return self
    }

    // MARK: common row delegate

    /// optional func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    @objc open var cellWillDisplay: FZTableViewRowData.CellWillDisplayClosure?

    @discardableResult
    open func setCellWillDisplay(_ block: FZTableViewRowData.CellWillDisplayClosure?) -> Self {
        cellWillDisplay = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
    @objc open var celldidEndDisplaying: FZTableViewRowData.CelldidEndDisplayingClosure?

    @discardableResult
    open func setCelldidEndDisplaying(_ block: FZTableViewRowData.CelldidEndDisplayingClosure?) -> Self {
        celldidEndDisplaying = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    @objc open var cellHeight: FZTableViewRowData.CellHeightClosure?

    @discardableResult
    open func setCellHeight(_ block: FZTableViewRowData.CellHeightClosure?) -> Self {
        cellHeight = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    @objc open var cellEstimatedHeight: FZTableViewRowData.CellEstimatedHeightClosure?

    @discardableResult
    open func setCellEstimatedHeight(_ block: FZTableViewRowData.CellEstimatedHeightClosure?) -> Self {
        cellEstimatedHeight = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath)
    @objc open var cellAccessoryButtonTapped: FZTableViewRowData.CellAccessoryButtonTappedClosure?

    @discardableResult
    open func setCellAccessoryButtonTapped(_ block: FZTableViewRowData.CellAccessoryButtonTappedClosure?) -> Self {
        cellAccessoryButtonTapped = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
    @objc open var cellShouldHighlight: FZTableViewRowData.CellShouldHighlightClosure?

    @discardableResult
    open func setCellShouldHighlight(_ block: FZTableViewRowData.CellShouldHighlightClosure?) -> Self {
        cellShouldHighlight = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath)
    @objc open var cellDidHighlight: FZTableViewRowData.CellDidHighlightClosure?

    @discardableResult
    open func setCellDidHighlight(_ block: FZTableViewRowData.CellDidHighlightClosure?) -> Self {
        cellDidHighlight = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath)
    @objc open var cellDidUnhighlight: FZTableViewRowData.CellDidUnhighlightClosure?

    @discardableResult
    open func setCellDidUnhighlight(_ block: FZTableViewRowData.CellDidUnhighlightClosure?) -> Self {
        cellDidUnhighlight = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
    @objc open var cellWillSelect: FZTableViewRowData.CellWillSelectClosure?

    @discardableResult
    open func setCellWillSelect(_ block: FZTableViewRowData.CellWillSelectClosure?) -> Self {
        cellWillSelect = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath?
    @objc open var cellWillDeselect: FZTableViewRowData.CellWillDeselectClosure?

    @discardableResult
    open func setCellWillDeselect(_ block: FZTableViewRowData.CellWillDeselectClosure?) -> Self {
        cellWillDeselect = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    @objc open var cellDidSelect: FZTableViewRowData.CellDidSelectClosure?

    @discardableResult
    open func setCellDidSelect(_ block: FZTableViewRowData.CellDidSelectClosure?) -> Self {
        cellDidSelect = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    @objc open var cellDidDeselect: FZTableViewRowData.CellDidDeselectClosure?

    @discardableResult
    open func setCellDidDeselect(_ block: FZTableViewRowData.CellDidDeselectClosure?) -> Self {
        cellDidDeselect = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    @objc open var cellEditingStyle: FZTableViewRowData.CellEditingStyleClosure?

    @discardableResult
    open func setCellEditingStyle(_ block: FZTableViewRowData.CellEditingStyleClosure?) -> Self {
        cellEditingStyle = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
    @objc open var cellTitleForDeleteConfirmationButton: FZTableViewRowData.CellTitleForDeleteConfirmationButtonClosure?

    @discardableResult
    open func setCellTitleForDeleteConfirmationButton(_ block: FZTableViewRowData.CellTitleForDeleteConfirmationButtonClosure?) -> Self {
        cellTitleForDeleteConfirmationButton = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    @objc open var cellEditActions: FZTableViewRowData.CellEditActionsClosure?

    @discardableResult
    open func setCellEditActions(_ block: FZTableViewRowData.CellEditActionsClosure?) -> Self {
        cellEditActions = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool
    @objc open var cellShouldIndentWhileEditing: FZTableViewRowData.CellShouldIndentWhileEditingClosure?

    @discardableResult
    open func setCellShouldIndentWhileEditing(_ block: FZTableViewRowData.CellShouldIndentWhileEditingClosure?) -> Self {
        cellShouldIndentWhileEditing = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath)
    @objc open var cellWillBeginEditing: FZTableViewRowData.CellWillBeginEditingClosure?

    @discardableResult
    open func setCellWillBeginEditing(_ block: FZTableViewRowData.CellWillBeginEditingClosure?) -> Self {
        cellWillBeginEditing = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?)
    @objc open var cellDidEndEditing: TableViewCellDidEndEditingClosure?

    @discardableResult
    open func setCellDidEndEditing(_ block: TableViewCellDidEndEditingClosure?) -> Self {
        cellDidEndEditing = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int
    @objc open var cellIndentationLevel: FZTableViewRowData.CellIndentationLevelClosure?

    @discardableResult
    open func setCellIndentationLevel(_ block: FZTableViewRowData.CellIndentationLevelClosure?) -> Self {
        cellIndentationLevel = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool
    @objc open var cellShouldShowMenu: FZTableViewRowData.CellShouldShowMenuClosure?

    @discardableResult
    open func setCellShouldShowMenu(_ block: FZTableViewRowData.CellShouldShowMenuClosure?) -> Self {
        cellShouldShowMenu = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool
    @objc open var cellCanPerformAction: FZTableViewRowData.CellCanPerformActionClosure?

    @discardableResult
    open func setCellCanPerformAction(_ block: FZTableViewRowData.CellCanPerformActionClosure?) -> Self {
        cellCanPerformAction = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?)
    @objc open var cellPerformAction: FZTableViewRowData.CellPerformActionClosure?

    @discardableResult
    open func setCellPerformAction(_ block: FZTableViewRowData.CellPerformActionClosure?) -> Self {
        cellPerformAction = block
        return self
    }
}

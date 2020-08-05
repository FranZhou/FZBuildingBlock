//
//  FZTableViewManager.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/2.
//

import Foundation
import UIKit

open class FZTableViewManager: NSObject {
    
    open var tableSectionsAndRowsData: FZTableViewSectionAndRowData?
    
    private func tableSectionData(section: Int) -> FZTableViewSectionData? {
        return tableSectionsAndRowsData?.sectionDatas?[fz_safe: section]
    }
    
    private func tableRowData(section: Int, row: Int) -> FZTableViewRowData? {
        return tableSectionData(section: section)?.sectionRowDatas?[fz_safe: row]
    }
    
    private func tableRowData(sectionData: FZTableViewSectionData, row: Int) -> FZTableViewRowData?{
        return sectionData.sectionRowDatas?[fz_safe: row]
    }
    
    private func tableRowData(indexPath: IndexPath) -> FZTableViewRowData?{
        return tableRowData(section: indexPath.section, row: indexPath.row)
    }
}

// MARK: UITableViewDelegate
extension FZTableViewManager: UITableViewDelegate {
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellWillDisplay{
            block(tableView, cell, indexPath)
        } else if let block = tableSectionsAndRowsData?.cellWillDisplay{
            block(tableView, cell, indexPath)
        }
    }
    
    @available(iOS 6.0, *)
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        if let sectionData = tableSectionData(section: section),
            let block = sectionData.sectionHeaderViewWillDisplay{
            block(tableView, view, section)
        } else if let block = tableSectionsAndRowsData?.sectionHeaderViewWillDisplay{
            block(tableView, view, section)
        }
    }
    
    @available(iOS 6.0, *)
    public func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int){
        if let sectionData = tableSectionData(section: section),
            let block = sectionData.sectionFooterViewWillDisplay{
            block(tableView, view, section)
        } else if let block = tableSectionsAndRowsData?.sectionFooterViewWillDisplay{
            block(tableView, view, section)
        }
    }
    
    @available(iOS 6.0, *)
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.celldidEndDisplaying{
            block(tableView, cell, indexPath)
        } else if let block = tableSectionsAndRowsData?.celldidEndDisplaying{
            block(tableView, cell, indexPath)
        }
    }
    
    @available(iOS 6.0, *)
    public func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int){
        if let sectionData = tableSectionData(section: section),
            let block = sectionData.sectionHeaderViewDidEndDisplay{
            block(tableView, view, section)
        } else if let block = tableSectionsAndRowsData?.sectionHeaderViewDidEndDisplay{
            block(tableView, view, section)
        }
    }
    
    @available(iOS 6.0, *)
    public func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int){
        if let sectionData = tableSectionData(section: section),
            let block = sectionData.sectionFooterViewDidEndDisplay{
            block(tableView, view, section)
        } else if let block = tableSectionsAndRowsData?.sectionFooterViewDidEndDisplay{
            block(tableView, view, section)
        }
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellHeight{
            return block(tableView, indexPath)
        } else if let block = tableSectionsAndRowsData?.cellHeight{
            return block(tableView, indexPath)
        }
        return tableView.estimatedRowHeight
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        if let sectionData = tableSectionData(section: section),
            let block = sectionData.sectionHeaderViewHeight{
            return block(tableView, section)
        } else if let block = tableSectionsAndRowsData?.sectionHeaderViewHeight{
            return block(tableView, section)
        }
        return tableView.estimatedSectionHeaderHeight
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        if let sectionData = tableSectionData(section: section),
            let block = sectionData.sectionFooterViewHeight{
            return block(tableView, section)
        } else if let block = tableSectionsAndRowsData?.sectionFooterViewHeight{
            return block(tableView, section)
        }
        return tableView.estimatedSectionFooterHeight
    }
    
    @available(iOS 7.0, *)
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellEstimatedHeight{
            return block(tableView, indexPath)
        } else if let block = tableSectionsAndRowsData?.cellEstimatedHeight{
            return block(tableView, indexPath)
        }
        return tableView.estimatedRowHeight
    }
    
    @available(iOS 7.0, *)
    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if let sectionData = tableSectionData(section: section),
            let block = sectionData.sectionHeaderViewEstimatedHeight{
            return block(tableView, section)
        } else if let block = tableSectionsAndRowsData?.sectionHeaderViewEstimatedHeight{
            return block(tableView, section)
        }
        return tableView.estimatedSectionHeaderHeight
    }
    
    @available(iOS 7.0, *)
    public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        if let sectionData = tableSectionData(section: section),
            let block = sectionData.sectionFooterViewEstimatedHeight{
            return block(tableView, section)
        } else if let block = tableSectionsAndRowsData?.sectionFooterViewEstimatedHeight{
            return block(tableView, section)
        }
        return tableView.estimatedSectionFooterHeight
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        if let sectionData = tableSectionData(section: section),
            let block = sectionData.sectionHeaderView{
            return block(tableView, section)
        } else if let block = tableSectionsAndRowsData?.sectionHeaderView{
            return block(tableView, section)
        }
        return nil
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{
        if let sectionData = tableSectionData(section: section),
            let block = sectionData.sectionFooterView{
            return block(tableView, section)
        } else if let block = tableSectionsAndRowsData?.sectionFooterView{
            return block(tableView, section)
        }
        return nil
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath){
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellAccessoryButtonTapped{
            block(tableView, indexPath)
        } else if let block = tableSectionsAndRowsData?.cellAccessoryButtonTapped{
            block(tableView, indexPath)
        }
    }
    
    @available(iOS 6.0, *)
    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool{
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellShouldHighlight{
            return block(tableView, indexPath)
        } else if let block = tableSectionsAndRowsData?.cellShouldHighlight{
            return block(tableView, indexPath)
        }
        return true
    }
    
    @available(iOS 6.0, *)
    public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath){
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellDidHighlight{
            block(tableView, indexPath)
        } else if let block = tableSectionsAndRowsData?.cellDidHighlight{
            block(tableView, indexPath)
        }
    }
    
    @available(iOS 6.0, *)
    public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath){
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellDidUnhighlight{
            block(tableView, indexPath)
        } else if let block = tableSectionsAndRowsData?.cellDidUnhighlight{
            block(tableView, indexPath)
        }
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellWillSelect{
            return block(tableView, indexPath)
        } else if let block = tableSectionsAndRowsData?.cellWillSelect{
            return block(tableView, indexPath)
        }
        return indexPath
    }
    
    @available(iOS 3.0, *)
    public func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath?{
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellWillDeselect{
            return block(tableView, indexPath)
        } else if let block = tableSectionsAndRowsData?.cellWillDeselect{
            return block(tableView, indexPath)
        }
        return indexPath
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellDidSelect{
            block(tableView, indexPath)
        } else if let block = tableSectionsAndRowsData?.cellDidSelect{
            block(tableView, indexPath)
        }
    }
    
    @available(iOS 3.0, *)
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellDidDeselect{
            block(tableView, indexPath)
        } else if let block = tableSectionsAndRowsData?.cellDidDeselect{
            block(tableView, indexPath)
        }
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle{
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellEditingStyle{
            return block(tableView, indexPath)
        } else if let block = tableSectionsAndRowsData?.cellEditingStyle{
            return block(tableView, indexPath)
        }
        return .none
    }
    
    @available(iOS 3.0, *)
    public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellTitleForDeleteConfirmationButton{
            return block(tableView, indexPath)
        }else if let block = tableSectionsAndRowsData?.cellTitleForDeleteConfirmationButton{
            return block(tableView, indexPath)
        }
        return "Delete"
    }
    
    @available(iOS, introduced: 8.0, deprecated: 13.0)
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?{
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellEditActions{
            return block(tableView, indexPath)
        } else if let block = tableSectionsAndRowsData?.cellEditActions{
            return block(tableView, indexPath)
        }
        return nil
    }
    
    @available(iOS 11.0, *)
    public func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        if let rowData = tableRowData(indexPath: indexPath),
            let rowDataAfteriOS11 = rowData as? FZTableViewRowDataAfteriOS11,
            let block = rowDataAfteriOS11.cellLeadingSwipeActionsConfiguration{
            return block(tableView, indexPath)
        }else if let sectionsAndRowsData = tableSectionsAndRowsData as? FZTableViewSectionAndRowDataAfteriOS11,
            let block = sectionsAndRowsData.cellLeadingSwipeActionsConfiguration{
            return block(tableView, indexPath)
        }
        return UISwipeActionsConfiguration()
    }
    
    @available(iOS 11.0, *)
    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        if let rowData = tableRowData(indexPath: indexPath) as? FZTableViewRowDataAfteriOS11,
            let block = rowData.cellTrailingSwipeActionsConfiguration{
            return block(tableView, indexPath)
        }else if let sectionsAndRowsData = tableSectionsAndRowsData as? FZTableViewSectionAndRowDataAfteriOS11,
            let block = sectionsAndRowsData.cellTrailingSwipeActionsConfiguration{
            return block(tableView, indexPath)
        }
        return UISwipeActionsConfiguration()
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool{
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellShouldIndentWhileEditing{
            return block(tableView, indexPath)
        } else if let block = tableSectionsAndRowsData?.cellShouldIndentWhileEditing{
            return block(tableView, indexPath)
        }
        return true
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath){
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellWillBeginEditing{
            block(tableView, indexPath)
        } else if let block = tableSectionsAndRowsData?.cellWillBeginEditing{
            block(tableView, indexPath)
        }
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?){
        if let indexPath = indexPath,
            let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellDidEndEditing{
            block(tableView, indexPath)
        } else if let block = tableSectionsAndRowsData?.cellDidEndEditing{
            block(tableView, indexPath)
        }
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath{
        if let block = tableSectionsAndRowsData?.tableViewCellTargetIndexPathForMove {
            return block(tableView, sourceIndexPath, proposedDestinationIndexPath)
        }
        return proposedDestinationIndexPath
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int{
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellIndentationLevel{
            return block(tableView, indexPath)
        } else if let block = tableSectionsAndRowsData?.cellIndentationLevel{
            return block(tableView, indexPath)
        }
        return 0
    }
    
    @available(iOS, introduced: 5.0, deprecated: 13.0)
    public func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool{
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellShouldShowMenu{
            return block(tableView, indexPath)
        } else if let block = tableSectionsAndRowsData?.cellShouldShowMenu{
            return block(tableView, indexPath)
        }
        return false
    }
    
    @available(iOS, introduced: 5.0, deprecated: 13.0)
    public func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool{
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellCanPerformAction{
            return block(tableView, action, indexPath, sender)
        } else if let block = tableSectionsAndRowsData?.cellCanPerformAction{
            return block(tableView, action, indexPath, sender)
        }
        return false
    }
    
    @available(iOS, introduced: 5.0, deprecated: 13.0)
    public func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?){
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellPerformAction{
            block(tableView, action, indexPath, sender)
        } else if let block = tableSectionsAndRowsData?.cellPerformAction{
            block(tableView, action, indexPath, sender)
        }
    }
    
    @available(iOS 9.0, *)
    public func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool{
        if let rowData = tableRowData(indexPath: indexPath) as? FZTableViewRowDataAfteriOS9,
            let block = rowData.cellCanFocus{
            return block(tableView, indexPath)
        } else if let sectionsAndRowsData = tableSectionsAndRowsData as? FZTableViewSectionAndRowDataAfteriOS9,
            let block = sectionsAndRowsData.cellCanFocus{
            return block(tableView, indexPath)
        }
        return true
    }
    
    @available(iOS 9.0, *)
    public func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool{
        if let sectionsAndRowsData = tableSectionsAndRowsData as? FZTableViewSectionAndRowDataAfteriOS9,
            let block = sectionsAndRowsData.tableViewShouldUpdateFocus{
            return block(tableView, context)
        }else if let sectionsAndRowsData = tableSectionsAndRowsData as? FZTableViewSectionAndRowDataAfteriOS9,
            let block = sectionsAndRowsData.tableViewShouldUpdateFocus{
            return block(tableView, context)
        }
        return true
    }
    
    @available(iOS 9.0, *)
    public func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator){
        if let sectionsAndRowsData = tableSectionsAndRowsData as? FZTableViewSectionAndRowDataAfteriOS9,
            let block = sectionsAndRowsData.tableViewDidUpdateFocus{
            block(tableView, context, coordinator)
        } else if let sectionsAndRowsData = tableSectionsAndRowsData as? FZTableViewSectionAndRowDataAfteriOS9,
            let block = sectionsAndRowsData.tableViewDidUpdateFocus{
            block(tableView, context, coordinator)
        }
    }
    
    @available(iOS 9.0, *)
    public func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath?{
        if let sectionsAndRowsData = tableSectionsAndRowsData as? FZTableViewSectionAndRowDataAfteriOS9,
            let block = sectionsAndRowsData.tableViewIndexPathForPreferredFocusedView{
            return block(tableView)
        } else if let sectionsAndRowsData = tableSectionsAndRowsData as? FZTableViewSectionAndRowDataAfteriOS9,
            let block = sectionsAndRowsData.tableViewIndexPathForPreferredFocusedView{
            return block(tableView)
        }
        return nil
    }
    
    @available(iOS 11.0, *)
    public func tableView(_ tableView: UITableView, shouldSpringLoadRowAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool{
        if let rowData = tableRowData(indexPath: indexPath) as? FZTableViewRowDataAfteriOS11,
            let block = rowData.cellShouldSpringLoad{
            return block(tableView, indexPath, context)
        } else if let sectionsAndRowsData = tableSectionsAndRowsData as? FZTableViewSectionAndRowDataAfteriOS11,
            let block = sectionsAndRowsData.cellShouldSpringLoad{
            return block(tableView, indexPath, context)
        }
        return true
    }
    
    @available(iOS 13.0, *)
    public func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool{
        if let rowData = tableRowData(indexPath: indexPath) as? FZTableViewRowDataAfteriOS13,
            let block = rowData.cellShouldBeginMultipleSelectionInteraction{
            return block(tableView, indexPath)
        } else if let sectionsAndRowsData = tableSectionsAndRowsData as? FZTableViewSectionAndRowDataAfteriOS13,
            let block = sectionsAndRowsData.cellShouldBeginMultipleSelectionInteraction{
            return block(tableView, indexPath)
        }
        return false
    }
    
    @available(iOS 13.0, *)
    public func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath){
        if let rowData = tableRowData(indexPath: indexPath) as? FZTableViewRowDataAfteriOS13,
            let block = rowData.cellDidBeginMultipleSelectionInteraction{
            block(tableView, indexPath)
        } else if let sectionsAndRowsData = tableSectionsAndRowsData as? FZTableViewSectionAndRowDataAfteriOS13,
            let block = sectionsAndRowsData.cellDidBeginMultipleSelectionInteraction{
            block(tableView, indexPath)
        }
    }
    
    @available(iOS 13.0, *)
    public func tableViewDidEndMultipleSelectionInteraction(_ tableView: UITableView){
        if let sectionsAndRowsData = tableSectionsAndRowsData as? FZTableViewSectionAndRowDataAfteriOS13,
            let block = sectionsAndRowsData.tableViewDidEndMultipleSelectionInteraction{
            block(tableView)
        } 
    }
    
    /**
     * @abstract Called when the interaction begins.
     *
     * @param tableView  This UITableView.
     * @param indexPath  IndexPath of the row for which a configuration is being requested.
     * @param point      Location of the interaction in the table view's coordinate space
     *
     * @return A UIContextMenuConfiguration describing the menu to be presented. Return nil to prevent the interaction from beginning.
     *         Returning an empty configuration causes the interaction to begin then fail with a cancellation effect. You might use this
     *         to indicate to users that it's possible for a menu to be presented from this element, but that there are no actions to
     *         present at this particular time.
     */
    @available(iOS 13.0, *)
    public func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration?{
        if let rowData = tableRowData(indexPath: indexPath) as? FZTableViewRowDataAfteriOS13,
            let block = rowData.cellContextMenuConfiguration{
            return block(tableView, indexPath, point)
        } else if let sectionsAndRowsData = tableSectionsAndRowsData as? FZTableViewSectionAndRowDataAfteriOS13,
            let block = sectionsAndRowsData.cellContextMenuConfiguration{
            return block(tableView, indexPath, point)
        }
        return nil
    }
    
    /**
     * @abstract Called when the interaction begins. Return a UITargetedPreview to override the default preview created by the table view.
     *
     * @param tableView      This UITableView.
     * @param configuration  The configuration of the menu about to be displayed by this interaction.
     */
    @available(iOS 13.0, *)
    public func tableView(_ tableView: UITableView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview?{
        if let sectionsAndRowsData = tableSectionsAndRowsData as? FZTableViewSectionAndRowDataAfteriOS13,
            let block = sectionsAndRowsData.tableViewPreviewForHighlightingContextMenuWithConfiguration{
            return block(tableView, configuration)
        } 
        return nil
    }
    
    /**
     * @abstract Called when the interaction is about to dismiss. Return a UITargetedPreview describing the desired dismissal target.
     * The interaction will animate the presented menu to the target. Use this to customize the dismissal animation.
     *
     * @param tableView      This UITableView.
     * @param configuration  The configuration of the menu displayed by this interaction.
     */
    @available(iOS 13.0, *)
    public func tableView(_ tableView: UITableView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview?{
        if let sectionsAndRowsData = tableSectionsAndRowsData as? FZTableViewSectionAndRowDataAfteriOS13,
            let block = sectionsAndRowsData.tableViewPreviewForDismissingContextMenuWithConfiguration{
            return block(tableView, configuration)
        }
        return nil
    }
    
    /**
     * @abstract Called when the interaction is about to "commit" in response to the user tapping the preview.
     *
     * @param tableView      This UITableView.
     * @param configuration  Configuration of the currently displayed menu.
     * @param animator       Commit animator. Add animations to this object to run them alongside the commit transition.
     */
    @available(iOS 13.0, *)
    public func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating){
        if let sectionsAndRowsData = tableSectionsAndRowsData as? FZTableViewSectionAndRowDataAfteriOS13,
            let block = sectionsAndRowsData.tableViewWillPerformPreviewActionForMenuConfiguration{
            block(tableView, configuration, animator)
        }
    }
    
}

// MARK: UITableViewDataSource
extension FZTableViewManager: UITableViewDataSource {
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let sectionData = tableSectionData(section: section){
            return sectionData.sectionRowDatas?.count ?? 0
        }
        return 0;
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell: UITableViewCell? = nil
        
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellDequeue{
            cell = block(tableView, indexPath)
        } else if let block = tableSectionsAndRowsData?.cellDequeue{
            cell = block(tableView, indexPath)
        }
        
        return cell ?? UITableViewCell()
    }
    
    @available(iOS 2.0, *)
    public func numberOfSections(in tableView: UITableView) -> Int {
        return tableSectionsAndRowsData?.sectionDatas?.count ?? 0
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        if let sectionData = tableSectionData(section: section),
            let block = sectionData.sectionHeaderTitle{
            return block(tableView, section)
        } else if let block = tableSectionsAndRowsData?.sectionHeaderTitle{
            return block(tableView, section)
        }
        return nil
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?{
        if let sectionData = tableSectionData(section: section),
            let block = sectionData.sectionFooterTitle{
            return block(tableView, section)
        } else if let block = tableSectionsAndRowsData?.sectionFooterTitle{
            return block(tableView, section)
        }
        return nil
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellCanEdit{
            return block(tableView, indexPath)
        }else if let block = tableSectionsAndRowsData?.cellCanEdit{
            return block(tableView, indexPath)
        }
        return true
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool{
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellCanMove{
            return block(tableView, indexPath)
        }else if let block = tableSectionsAndRowsData?.cellCanMove{
            return block(tableView, indexPath)
        }
        return false
    }
    
    @available(iOS 2.0, *)
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if let block = tableSectionsAndRowsData?.tableViewSectionIndexTitles{
            return block(tableView)
        }
        return nil
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        if let block = tableSectionsAndRowsData?.tableViewSectionForSectionIndexTitle {
            return block(tableView, title, index)
        }
        return index
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if let rowData = tableRowData(indexPath: indexPath),
            let block = rowData.cellCommitEditingStyle {
            block(tableView, editingStyle, indexPath)
        } else if let block = tableSectionsAndRowsData?.cellCommitEditingStyle {
            block(tableView, editingStyle, indexPath)
        }
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath){
        if let block = tableSectionsAndRowsData?.tableViewCellMove{
            block(tableView, sourceIndexPath, destinationIndexPath)
        }
    }
    
}

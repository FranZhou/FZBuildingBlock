//
//  FZTableViewSectionData.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/7/29.
//

import Foundation

@objc open class FZTableViewSectionData: NSObject {

    // MARK: - tableview closure

    public typealias TableViewSectionStringClosure = (_ tableView: UITableView, _ section: Int) -> String?

    public typealias TableViewViewSectionVoidClosure = (_ tableView: UITableView, _ view: UIView, _ section: Int) -> Void

    public typealias TableViewSectionFloatClosure = (_ tableView: UITableView, _ section: Int) -> CGFloat

    public typealias TableViewSectionViewClosure = (_ tableView: UITableView, _ section: Int) -> UIView?

    // MARK: - section closure

    public typealias SectionHeadertitleClosure = TableViewSectionStringClosure

    public typealias SectionFooterTitleClosure = TableViewSectionStringClosure

    public typealias SectionHeaderViewWillDisplayClosure = TableViewViewSectionVoidClosure

    public typealias SectionFooterViewWillDisplayClosure = TableViewViewSectionVoidClosure

    public typealias SectionHeaderViewDidEndDisplayClosure = TableViewViewSectionVoidClosure

    public typealias SectionFooterViewDidEndDisplayClosure = TableViewViewSectionVoidClosure

    public typealias SectionHeaderViewHeightClosure = TableViewSectionFloatClosure

    public typealias SectionFooterViewHeightClosure = TableViewSectionFloatClosure

    public typealias SectionHeaderViewEstimatedHeightClosure = TableViewSectionFloatClosure

    public typealias SectionFooterViewEstimatedHeightClosure = TableViewSectionFloatClosure

    public typealias SectionHeaderViewClosure = TableViewSectionViewClosure

    public typealias SectionFooterViewClosure = TableViewSectionViewClosure

    // MARK: - property
    /// section rows
    @objc open var sectionRowDatas: [FZTableViewRowData]?

    open func setSectionRowDatas(_ rowDatas: [FZTableViewRowData]?) -> Self {
        sectionRowDatas = rowDatas
        return self
    }

    // MARK: - init
    public override init() {

    }

    // MARK: - dataSource

    /// optional func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    @objc open var sectionHeaderTitle: SectionHeadertitleClosure?

    @discardableResult
    open func setSectionHeadertitle(_ block: SectionHeadertitleClosure?) -> Self {
        sectionHeaderTitle = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    @objc open var sectionFooterTitle: SectionFooterTitleClosure?

    @discardableResult
    open func setSectionFooterTitle(_ block: SectionFooterTitleClosure?) -> Self {
        sectionFooterTitle = block
        return self
    }

    // MARK: - delegate

    /// optional func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    @objc open var sectionHeaderViewWillDisplay: SectionHeaderViewWillDisplayClosure?

    @discardableResult
    open func setSectionHeaderViewWillDisplay(_ block: SectionHeaderViewWillDisplayClosure?) -> Self {
        sectionHeaderViewWillDisplay = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int)
    @objc open var sectionFooterViewWillDisplay: SectionFooterViewWillDisplayClosure?

    @discardableResult
    open func setSectionFooterViewWillDisplay(_ block: SectionFooterViewWillDisplayClosure?) -> Self {
        sectionFooterViewWillDisplay = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int)
    @objc open var sectionHeaderViewDidEndDisplay: SectionHeaderViewDidEndDisplayClosure?

    @discardableResult
    open func setSectionHeaderViewDidEndDisplay(_ block: SectionHeaderViewDidEndDisplayClosure?) -> Self {
        sectionHeaderViewDidEndDisplay = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int)
    @objc open var sectionFooterViewDidEndDisplay: SectionFooterViewDidEndDisplayClosure?

    @discardableResult
    open func setSectionFooterViewDidEndDisplay(_ block: SectionFooterViewDidEndDisplayClosure?) -> Self {
        sectionFooterViewDidEndDisplay = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    @objc open var sectionHeaderViewHeight: SectionHeaderViewHeightClosure?

    @discardableResult
    open func setSectionHeaderViewHeight(_ block: SectionHeaderViewHeightClosure?) -> Self {
        sectionHeaderViewHeight = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    @objc open var sectionFooterViewHeight: SectionFooterViewHeightClosure?

    @discardableResult
    open func setSectionFooterViewHeight(_ block: SectionFooterViewHeightClosure?) -> Self {
        sectionFooterViewHeight = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat
    @objc open var sectionHeaderViewEstimatedHeight: SectionHeaderViewEstimatedHeightClosure?

    @discardableResult
    open func setSectionHeaderViewEstimatedHeight(_ block: SectionHeaderViewEstimatedHeightClosure?) -> Self {
        sectionHeaderViewEstimatedHeight = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat
    @objc open var sectionFooterViewEstimatedHeight: SectionFooterViewEstimatedHeightClosure?

    @discardableResult
    open func setSectionFooterViewEstimatedHeight(_ block: SectionFooterViewEstimatedHeightClosure?) -> Self {
        sectionFooterViewEstimatedHeight = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    @objc open var sectionHeaderView: SectionHeaderViewClosure?

    @discardableResult
    open func setSectionHeaderView(_ block: SectionHeaderViewClosure?) -> Self {
        sectionHeaderView = block
        return self
    }

    /// optional func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    @objc open var sectionFooterView: SectionFooterViewClosure?

    @discardableResult
    open func setSectionFooterView(_ block: SectionFooterViewClosure?) -> Self {
        sectionFooterView = block
        return self
    }

}

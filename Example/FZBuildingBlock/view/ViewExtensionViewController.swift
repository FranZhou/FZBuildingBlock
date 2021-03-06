//
//  ViewExtensionViewController.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/2/27.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import FZBuildingBlock

struct FZBundleInfoConfig {

    @FZBundleInfo(key: "CFBundleDisplayName", defaultValue: "")
    static var bundleDisplayName: String

    @FZBundleInfo(key: "CFBundleVersion", defaultValue: "")
    static var bundleVersion: String

    @FZBundleInfo(key: "CFBundleShortVersionString", defaultValue: "")
    static var bundleShortVersionString: String
}

class ViewExtensionViewController: UIViewController {

    lazy var tableView: FZTableView = {
        let navigationBarAndStatusBarHeight: CGFloat = self.navigationController?.fz.navigationBarAndStatusBarHeight ?? 0

        let tableView = FZTableView(frame: self.view.bounds, style: .plain)
        tableView.tableViewManager = FZTableViewManager()
        tableView.register(FZTableViewCommonCell.classForCoder(), forCellReuseIdentifier: FZTableViewCommonCell.reuseIdentifier())
        return tableView
    }()

    lazy var tableViewData: [FZTableViewSectionData] = {
        var tableViewData: [FZTableViewSectionData] = []

        // FZTableViewSection
        do {
            var section = FZTableViewSectionData()
            var sectionRows: [TableViewCommonRowData] = []

            // 指定边框
            do {
                var cellModel = FZTableViewCellModel()
                cellModel.leftString = "指定边框"

                var row = TableViewCommonRowData()
                row.cellData = cellModel
                row.identifier = FZTableViewCommonCell.reuseIdentifier()
                row.cellClassName = NSStringFromClass(FZTableViewCommonCell.self.classForCoder())
                row.cellDidSelect = { [weak self](_, _) in
                    let vc = ViewBorderLineViewController.self()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                sectionRows.append(row)
            }

            // 按钮图片文字位置
            do {
                var cellModel = FZTableViewCellModel()
                cellModel.leftString = "按钮图片文字位置"

                var row = TableViewCommonRowData()
                row.cellData = cellModel
                row.identifier = FZTableViewCommonCell.reuseIdentifier()
                row.cellClassName = NSStringFromClass(FZTableViewCommonCell.classForCoder())
                row.cellDidSelect = { [weak self](_, _) in
                    let vc = ButtonLayoutViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                sectionRows.append(row)
            }

            // 验证码
            do {
                var cellModel = FZTableViewCellModel()
                cellModel.leftString = "验证码"

                var row = TableViewCommonRowData()
                row.cellData = cellModel
                row.identifier = FZTableViewCommonCell.reuseIdentifier()
                row.cellClassName = NSStringFromClass(FZTableViewCommonCell.classForCoder())
                row.cellDidSelect = { [weak self](_, _) in
                    let vc = CaptchaViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                sectionRows.append(row)
            }

            // 页面主题切换
            do {
                var cellModel = FZTableViewCellModel()
                cellModel.leftString = "页面主题切换"

                var row = TableViewCommonRowData()
                row.cellData = cellModel
                row.identifier = FZTableViewCommonCell.reuseIdentifier()
                row.cellClassName = NSStringFromClass(FZTableViewCommonCell.classForCoder())
                row.cellDidSelect = { [weak self](_, _) in
                    let vc = ThemeViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                sectionRows.append(row)
            }

            section.sectionRowDatas = sectionRows
            tableViewData.append(section)
        }

        return tableViewData
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.view.addSubview(self.tableView)

        print(FZBundleInfoConfig.bundleDisplayName)
        print(FZBundleInfoConfig.bundleVersion)
        print(FZBundleInfoConfig.bundleShortVersionString)

        // 测试责任链模式
        self.testResponsibilityChain()

        let sectionAndRowData = FZTableViewSectionAndRowData()
        sectionAndRowData.sectionDatas = tableViewData

        // common cell
        sectionAndRowData.setCell { (tableView, indexPath) -> UITableViewCell in
            var cell: UITableViewCell?

            if let tableView = tableView as? FZTableView,
                let sectionData = tableView.tableViewManager?.tableSectionsAndRowsData?.sectionDatas?[fz_safe: indexPath.section],
                let rowData = sectionData.sectionRowDatas?[fz_safe: indexPath.row] as? TableViewCommonRowData {

                if let identifier = rowData.identifier {
                    cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                }
                if cell == nil {
                    if let cellClassName = rowData.cellClassName,
                        let clz = NSClassFromString(cellClassName),
                        clz is UITableViewCell.Type {
                        cell = (clz as! UITableViewCell.Type).init(style: .default, reuseIdentifier: rowData.identifier ?? cellClassName)
                    } else {
                        if FZTableViewCell.classForCoder() is UITableViewCell.Type {
                            cell = (FZTableViewCell.classForCoder() as! UITableViewCell.Type).init(style: .default, reuseIdentifier: rowData.identifier ?? "FZTableViewCell")
                        }
                    }
                }

                if let cell = cell {
                    if cell.isKind(of: FZTableViewCell.classForCoder()) {
                        (cell as! FZTableViewCell).updateCell(withData: rowData.cellData, atIndexPath: indexPath)
                    }
                }
            }

            return cell ?? UITableViewCell()
        }

        tableView.updateTableViewManager(withData: sectionAndRowData)
    }

    deinit {
        print("ViewExtensionViewController deinit")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewExtensionViewController {

    func testResponsibilityChain() {
        let context = FZResponsibilityChainContext<Int>()

        context.createResponsibilityChainHandler().setConditioon { (data) -> Bool in
            return data >= 0 && data < 10
        }.setExecute { (data) in
            print("Matching1 --> \(data)")
        }

        context.createResponsibilityChainHandler().setConditioon { (data) -> Bool in
            return data >= 10 && data < 100
        }.setExecute { (data) in
            print("Matching2 --> \(data)")
        }

        context.createResponsibilityChainHandler().setConditioon { (data) -> Bool in
            return data >= 100 && data < 1000
        }.setExecute { (data) in
            print("Matching3 --> \(data)")
        }

        context.createMatchingFailureHandler().setExecute { (data) in
            print("MatchingFailure --> \(data)")
        }

        context.handlerExecute(with: 1)

        context.handlerExecute(with: 77)

        context.handlerExecute(with: 777)

        context.handlerExecute(with: -1)

    }

}

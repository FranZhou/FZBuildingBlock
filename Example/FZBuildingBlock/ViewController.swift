//
//  ViewController.swift
//  FZBuildingBlock
//
//  Created by zhoufan123 on 02/20/2019.
//  Copyright (c) 2019 zhoufan123. All rights reserved.
//

import UIKit
import FZBuildingBlock

class ViewController: UIViewController {

    lazy var tableView: FZTableView = {
        let navigationBarAndStatusBarHeight: CGFloat = self.navigationController?.fz.navigationBarAndStatusBarHeight ?? 0

        let tableView = FZTableView(frame: CGRect(x: 0, y: navigationBarAndStatusBarHeight, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - navigationBarAndStatusBarHeight), style: .plain)
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

            // 图片处理
            do {
                var font: UIFont?
                if let filePath = Bundle.main.path(forResource: "毛泽东字体", ofType: "ttf"),
                    let fontName = UIFont.fz.registerTTFFont(withFilePath: filePath) {
                    font = UIFont(name: fontName, size: 13)
                }

                var cellModel = FZTableViewCellModel()
                cellModel.leftAttributedString = NSMutableAttributedString(string: "图片处理").fz.set(attribute: FZAttribute.font(font ?? UIFont.systemFont(ofSize: 13)))

                cellModel.rightString = "->"

                var row = TableViewCommonRowData()
                row.cellData = cellModel
                row.identifier = FZTableViewCommonCell.reuseIdentifier()
                row.cellClassName = NSStringFromClass(FZTableViewCommonCell.classForCoder())
                row.cellHeight = { (tableView, indexPath) in
                    return 44
                }
                row.cellDidSelect = { [weak self](tableView, indexPath) in
                    let vc = ImageViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                sectionRows.append(row)
            }

            // 观察者
            do {

                var font: UIFont?
                if let filePath = Bundle.main.path(forResource: "simsun", ofType: "ttc"),
                    let fontNames = UIFont.fz.registerTTCFont(withFilePath: filePath) {
                    font = UIFont(name: fontNames[0], size: 18)
                }

                var cellModel = FZTableViewCellModel()
                cellModel.leftAttributedString = NSMutableAttributedString(string: "观察者").fz.set(attribute: FZAttribute.font(font ?? UIFont.systemFont(ofSize: 13)))

                var row = TableViewCommonRowData()
                row.cellData = cellModel
                row.identifier = FZTableViewCommonCell.reuseIdentifier()
                row.cellClassName = NSStringFromClass(FZTableViewCommonCell.self.classForCoder())
                row.cellHeight = { (tableView, indexPath) in
                    return 44
                }
                row.cellDidSelect = { [weak self](tableView, indexPath) in
                    let vc = ObserverViewController.self()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                sectionRows.append(row)
            }

            // 图片处理
            do {
                var cellModel = FZTableViewCellModel()
                cellModel.leftString = "键盘通知监听"

                var row = TableViewCommonRowData()
                row.cellData = cellModel
                row.identifier = FZTableViewCommonCell.reuseIdentifier()
                row.cellClassName = NSStringFromClass(FZTableViewCommonCell.self.classForCoder())
                row.cellHeight = { (tableView, indexPath) in
                    return 44
                }
                row.cellDidSelect = { [weak self](tableView, indexPath) in
                    let vc = KeyboardObserverViewController.self()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                sectionRows.append(row)
            }

            // view扩展
            do {
                var cellModel = FZTableViewCellModel()
                cellModel.leftString = "view扩展"

                var row = TableViewCommonRowData()
                row.cellData = cellModel
                row.identifier = FZTableViewCommonCell.reuseIdentifier()
                row.cellClassName = NSStringFromClass(FZTableViewCommonCell.classForCoder())
                row.cellHeight = { (tableView, indexPath) in
                    return 44
                }
                row.cellDidSelect = { [weak self](tableView, indexPath) in
                    let vc = ViewExtensionViewController()
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
        // Do any additional setup after loading the view, typically from a nib.

//        self.edgesForExtendedLayout = UIRectEdge()
//        self.automaticallyAdjustsScrollViewInsets = false

        self.view.addSubview(self.tableView)

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
                        if (FZTableViewCell.classForCoder() is UITableViewCell.Type) {
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }

    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        print("fz_statusBarHeight -> \(UIApplication.shared.fz.statusBarHeight)")

        print("fz_safeArea -> \(UIApplication.shared.fz.safeArea)")

        print("fz_navigationBarHeight -> \(String(describing: self.navigationController?.fz.navigationBarHeight))")
        print("fz_navigationBarAndStatusBarHeight -> \(String(describing: self.navigationController?.fz.navigationBarAndStatusBarHeight))")
        print("fz_tabBarHeight -> \(String(describing: self.tabBarController?.fz.tabBarHeight))")
        print("fz_tabBarAndSafeAreaHeight -> \(String(describing: self.tabBarController?.fz.tabBarAndSafeAreaHeight))")
    }

}

extension ViewController {

    func testResponsibilityChain() {
        let context = FZResponsibilityChainContext<Int>()

        context.createResponsibilityChainHandler().setConditioon { (data) -> Bool in
            return data > 0 && data < 10
        }.setExecute { (data) in
            print("Matching1 --> \(data)")
        }

        context.createResponsibilityChainHandler().setConditioon { (data) -> Bool in
            return data >= 0 && data < 100
        }.setExecute { (data) in
            print("Matching2 --> \(data)")
        }

        context.createResponsibilityChainHandler().setConditioon { (data) -> Bool in
            return data >= 100 && data <= 1000
        }.setExecute { (data) in
            print("Matching3 --> \(data)")
        }

        context.createMatchingFailureHandler().setExecute { (data) in
            print("MatchingFailure --> \(data)")
        }

        context.handler(responsibilityData: 1)

        context.handler(responsibilityData: 77)

        context.handler(responsibilityData: 777)

        context.handler(responsibilityData: -1)

    }

}

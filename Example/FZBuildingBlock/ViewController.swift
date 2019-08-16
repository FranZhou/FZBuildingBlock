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
        let navigationBarAndStatusBarHeight: CGFloat = self.navigationController?.fz_navigationBarAndStatusBarHeight ?? 0
        
        let tableView = FZTableView(frame: CGRect(x: 0, y: navigationBarAndStatusBarHeight, width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height - navigationBarAndStatusBarHeight), style: .plain)
        tableView.tableViewManager = TableViewManager()
        tableView.register(FZTableViewCommonCell.classForCoder(), forCellReuseIdentifier: FZTableViewCommonCell.reuseIdentifier())
        return tableView
    }()
    
    lazy var tableViewData: [FZTableViewSection] = {
        var tableViewData: [FZTableViewSection] = []
        
        // FZTableViewSection
        do{
            var section = FZTableViewSection()
            var sectionRows: [FZTableViewRow] = []
            
            // 图片处理
            do{
                var font: UIFont? = nil
                if let filePath = Bundle.main.path(forResource: "毛泽东字体", ofType: "ttf"),
                    let fontName = UIFont.fz_registerTTFFont(withFilePath: filePath){
                    font = UIFont(name: fontName, size: 13)
                }
                
                var cellModel = FZTableViewCellModel()
                cellModel.leftAttributedString = NSMutableAttributedString(string: "图片处理").fz_set(attribute: NSAttributedString.FZAttribute.font(font ?? UIFont.systemFont(ofSize: 13)))
                
                cellModel.rightString = "->"
                
                var row = FZTableViewRow()
                row.cellData = cellModel
                row.identifier = FZTableViewCommonCell.reuseIdentifier()
                row.cellClassName = NSStringFromClass(FZTableViewCommonCell.classForCoder())
                row.cellHeightBlock = { (tableView, indexPath) in
                    return 44
                }
                row.cellDidSelectBlock = { [weak self](tableView, indexPath) in
                    let vc = ImageViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                sectionRows.append(row)
            }
            
            // 观察者
            do{
                
                var font: UIFont? = nil
                if let filePath = Bundle.main.path(forResource: "simsun", ofType: "ttc"),
                    let fontNames = UIFont.fz_registerTTCFont(withFilePath: filePath){
                    font = UIFont(name: fontNames[0], size: 18)
                }
                
                var cellModel = FZTableViewCellModel()
                cellModel.leftAttributedString = NSMutableAttributedString(string: "观察者").fz_set(attribute: NSAttributedString.FZAttribute.font(font ?? UIFont.systemFont(ofSize: 13)))
                
                
                var row = FZTableViewRow()
                row.cellData = cellModel
                row.identifier = FZTableViewCommonCell.reuseIdentifier()
                row.cellClassName = NSStringFromClass(FZTableViewCommonCell.self.classForCoder())
                row.cellHeightBlock = { (tableView, indexPath) in
                    return 44
                }
                row.cellDidSelectBlock = { [weak self](tableView, indexPath) in
                    let vc = ObserverViewController.self()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                sectionRows.append(row)
            }
            
            // 图片处理
            do{
                var cellModel = FZTableViewCellModel()
                cellModel.leftString = "键盘通知监听"
                
                var row = FZTableViewRow()
                row.cellData = cellModel
                row.identifier = FZTableViewCommonCell.reuseIdentifier()
                row.cellClassName = NSStringFromClass(FZTableViewCommonCell.self.classForCoder())
                row.cellHeightBlock = { (tableView, indexPath) in
                    return 44
                }
                row.cellDidSelectBlock = { [weak self](tableView, indexPath) in
                    let vc = KeyboardObserverViewController.self()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                sectionRows.append(row)
            }
            
            // view扩展
            do{
                var cellModel = FZTableViewCellModel()
                cellModel.leftString = "view扩展"
                
                var row = FZTableViewRow()
                row.cellData = cellModel
                row.identifier = FZTableViewCommonCell.reuseIdentifier()
                row.cellClassName = NSStringFromClass(FZTableViewCommonCell.classForCoder())
                row.cellHeightBlock = { (tableView, indexPath) in
                    return 44
                }
                row.cellDidSelectBlock = { [weak self](tableView, indexPath) in
                    let vc = ViewExtensionViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                sectionRows.append(row)
            }
            
            section.sectionRows = sectionRows
            tableViewData.append(section)
        }
        
        return tableViewData
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(self.tableView)
        
        tableView.updateTableView(withData: tableViewData)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension ViewController{
    
    override var shouldAutorotate: Bool{
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .all
    }
    
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        print("fz_statusBarHeight -> \(UIApplication.shared.fz_statusBarHeight)")
        
        print("fz_safeArea -> \(UIApplication.shared.fz_safeArea)")
        
        
        print("fz_navigationBarHeight -> \(self.navigationController?.fz_navigationBarHeight)")
        print("fz_navigationBarAndStatusBarHeight -> \(self.navigationController?.fz_navigationBarAndStatusBarHeight)")
        print("fz_tabBarHeight -> \(self.tabBarController?.fz_tabBarHeight)")
        print("fz_tabBarAndSafeAreaHeight -> \(self.tabBarController?.fz_tabBarAndSafeAreaHeight)")
    }
    
}

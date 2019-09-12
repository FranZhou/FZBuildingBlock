//
//  ViewExtensionViewController.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/2/27.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ViewExtensionViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    let datas: [[(title: String, clzType: UIViewController.Type)]] = [
        [
            (title: "指定边框", clzType: ViewBorderLineViewController.self),
            (title: "按钮图片文字位置", clzType: ButtonLayoutViewController.self)
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.view.addSubview(self.tableView)
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

extension ViewExtensionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.datas.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }

        let data = self.datas[indexPath.section][indexPath.row]
        cell?.textLabel?.text = data.title

        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let clzType = self.datas[indexPath.section][indexPath.row].clzType

        let vc = clzType.init()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

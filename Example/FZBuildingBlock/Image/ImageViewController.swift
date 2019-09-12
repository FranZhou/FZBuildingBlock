//
//  ImageViewController.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/2/18.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    let datas: [[(title: String, clzType: UIViewController.Type)]] = [
        [
            (title: "纯色图片", clzType: ImageColorViewController.self),
            (title: "图片旋转图片", clzType: ImageRotationViewController.self),
            (title: "文字图片", clzType: StringImageViewController.self),
            (title: "图片圆角", clzType: ImageCornerRadiusViewController.self),
            (title: "GIF图片", clzType: GIFImageViewController.self),
            (title: "显示大图", clzType: LargeImageViewController.self)
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

extension ImageViewController: UITableViewDelegate, UITableViewDataSource {
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

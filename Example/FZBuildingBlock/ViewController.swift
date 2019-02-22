//
//  ViewController.swift
//  FZBuildingBlock
//
//  Created by zhoufan123 on 02/20/2019.
//  Copyright (c) 2019 zhoufan123. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    let datas: [[(title: String, clzType: UIViewController.Type)]] = [
        [
            (title: "图片处理", clzType: ImageViewController.self)
        ],
        [
            (title: "观察者", clzType: ObserverViewController.self)
        ],
        [
            (title: "键盘通知监听", clzType: KeyboardObserverViewController.self)
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(self.tableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
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



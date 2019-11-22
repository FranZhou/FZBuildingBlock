//
//  ObserverViewController.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/2/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import FZBuildingBlock

class ObserverViewController: UIViewController {

    var observer: ObserveAble<Int?>?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.observer = ObserveAble<Int?>(value: nil)

        self.observer?.bindAndFireObserver(key: "observer test1", target: self, action: {(value, fireAtOnce) in
            print("bindAndFireObserver: \(value) -> \(fireAtOnce)")
            print(Thread.current)
        })

        self.observer?.fireUntilCompleted(key: "observer test2", target: self, immediate: true, action: { (arg0, finish) in
            let (_, newValue) = arg0
            print("fireUntilCompleted: \(arg0)")
            guard let v = newValue, v%3 == 0  else {
                return
            }
            finish()
        })

        self.setUpView()
    }

    func setUpView() {
        let btn = UIButton(type: .custom)
        btn.fz.x = 100
        btn.fz.y = 200
        btn.fz.width = 200
        btn.fz.height = 50
        btn.setTitle("触发监听", for: .normal)
        btn.addTarget(self, action: #selector(ObserverViewController.btnClickAction(sender:)), for: .touchUpInside)

        self.view.addSubview(btn)
    }

    @objc func btnClickAction(sender: Any) {
        self.observer?.update(value: Int(arc4random()))
    }

    deinit {
        // observer能自动释放了
//        self.observer?.removeObserver(key: "observer test1")
//        self.observer?.removeObserver(key: "observer test2")

        print("ObserverViewController deinit")
    }

}

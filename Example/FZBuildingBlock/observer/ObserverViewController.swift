//
//  ObserverViewController.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/2/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import FZBuildingBlock
import FZObserver

class ObserverViewController: UIViewController {

    var observer: FZObserver<Int?>?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.observer = FZObserver<Int?>(wrappedValue: nil)

        self.observer?.addObserver(key: "observer test1", target: self, count: 2, action: {(oldVal, newVal) in
            print("bindObserver: \(String(describing: oldVal)) -> \(String(describing: newVal))")
        })

        self.observer?.fireUntilCompleted(key: "observer test2", target: self, immediately: true, action: { [weak self](arg0, finish) in
            let (_, newValue) = arg0
            print("fireUntilCompleted: \(arg0)")
            guard let v = newValue, v%3 == 0  else {
                return
            }
            finish()

            self?.observer?.removeObserver(key: "observer test3", target: self)
        })

        self.observer?.addAndFireObserver(key: "observer test3", target: self, action: {(value, fireAtOnce) in
            print("bindAndFireObserver -----> : \(value) -> \(fireAtOnce)")
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
        self.observer?.wrappedValue = Int(arc4random())
    }

    deinit {
        print("\(self) ObserverViewController deinit")
    }

}

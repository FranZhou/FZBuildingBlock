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
        
        self.observer?.bindAndFireObserver(key: "observer test1", action: {(value, fireAtOnce) in
            print("bindAndFireObserver: \(value) -> \(fireAtOnce)")
        })
        
        self.observer?.fireUntilCompleted(key: "observer test2", immediate: true, action: { (arg0, finish) in
            let (_, newValue) = arg0
            print("fireUntilCompleted: \(newValue)")
            guard let v = newValue, v%3 == 0  else {
                return
            }
            finish()
        })
        
        self.setUpView()
    }
    

    func setUpView() {
        let btn = UIButton(type: .custom)
        btn.fz_x = 100
        btn.fz_y = 200
        btn.fz_width = 200
        btn.fz_height = 50
        btn.setTitle("触发监听", for: .normal)
        btn.addTarget(self, action: #selector(ObserverViewController.btnClickAction(sender:)), for: .touchUpInside)
        
        self.view.addSubview(btn)
    }
    
    
    @objc func btnClickAction(sender: Any){
        self.observer?.update(value: Int(arc4random()))
    }
    
    
    deinit {
        self.observer?.removeObserver(key: "observer test1")
        self.observer?.removeObserver(key: "observer test2")

        print("ObserverViewController deinit")
    }

}

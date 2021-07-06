//
//  AssociatedViewController.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2020/9/4.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import FZBuildingBlock

class AssociatedViewController: UIViewController {

    var object: NSObject?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    deinit {
        print("AssociatedViewController deinit")
    }

}

extension AssociatedViewController {

    // struct数据 weak 和 normal效果一样
    var testIntProperty: Int? {
        get {
            return FZAssociatedObjects.default.getAssociatedObject(self, key: "testIntProperty" as AnyObject) as? Int
        }
        set {
            FZAssociatedObjects.default.setAssociatedObject(self, key: "testIntProperty" as AnyObject, value: newValue as AnyObject?, policy: .weak)
        }
    }

    var testWeakProperty: NSObject? {
        get {
            return FZAssociatedObjects.default.getAssociatedObject(self, key: "testWeakProperty" as AnyObject) as? NSObject
        }
        set {
            FZAssociatedObjects.default.setAssociatedObject(self, key: "testWeakProperty" as AnyObject, value: newValue as AnyObject?, policy: .weak)
        }
    }

    var testBlockProperty: ((String) -> String)? {
        get {
            return FZAssociatedObjects.default.getAssociatedObject(self, key: "testBlockProperty" as AnyObject) as? (String) -> String
        }
        set {
            FZAssociatedObjects.default.setAssociatedObject(self, key: "testBlockProperty" as AnyObject, value: newValue as AnyObject?, policy: .normal)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("==========")

        print("===== testIntProperty start =====")
        print("\(String(describing: testIntProperty))")
        testIntProperty = (testIntProperty ?? 0) + 1
        print("\(String(describing: testIntProperty))")
        print("===== testIntProperty end =====")

        print("===== testWeakProperty start =====")
        let obj = self.object
        print("\(String(describing: testWeakProperty))")
        testWeakProperty = obj
        print("\(String(describing: testWeakProperty))")
        self.object = obj ?? NSObject()
        print("===== testWeakProperty end =====")

        print("===== testBlockProperty start =====")
        print("\(String(describing: testBlockProperty))")
        testBlockProperty = { (str) in
            let res = "\(str) -->"
            print(res)
            return res
        }
        print("\(String(describing: testBlockProperty))")
        _ = testBlockProperty?("H")
        print("===== testBlockProperty end =====")

        print("==========")
    }

}

//
//  ViewBorderLineViewController.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/2/27.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import FZBuildingBlock

class ViewBorderLineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.view.backgroundColor = .white

        self.title = "指定边框"

        self.setUpView()
    }

    func setUpView() {
        let btn = UIButton(type: .custom)
        btn.fz.x = 100
        btn.fz.y = 100
        btn.fz.width = 200
        btn.fz.height = 50
        btn.setTitle("旋转当前图片", for: .normal)
        btn.setTitleColor(UIColor.fz.randomColor(), for: .normal)
        btn.addTarget(self, action: #selector(ImageColorViewController.btnClickAction(sender:)), for: .touchUpInside)
        self.view.addSubview(btn)

        let view1 = UIView(frame: CGRect(x: 50, y: 200, width: 100, height: 100))
        view1.layer.masksToBounds = true
        view1.backgroundColor = UIColor.fz.randomColor()
        view1.fz.addBorderLine(lineSides: .top, lineWidth: 1, lineColor: UIColor.fz.randomColor())
        self.view.addSubview(view1)

        let view2 = UIView(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
        view2.layer.masksToBounds = false
        view2.backgroundColor = UIColor.fz.randomColor()
        view2.fz.addBorderLine(lineSides: [.top, .bottom], lineWidth: 25, lineColor: UIColor.fz.randomColor())
        self.view.addSubview(view2)

        let view3 = UIView(frame: CGRect(x: 50, y: 350, width: 100, height: 100))
        view3.layer.masksToBounds = true
        view3.backgroundColor = UIColor.fz.randomColor()
        view3.fz.addBorderLine(lineSides: [.top, .left, .bottom, .right], lineWidth: 10, lineColor: UIColor.fz.randomColor(), lineDashPattern: [2, 3])
        self.view.addSubview(view3)

    }

    @objc func btnClickAction(sender: Any) {
        guard let view = self.view.subviews.last else {
            return
        }

        view.fz.addBorderLine(lineSides: FZViewBorderLineSideType(rawValue: Int(arc4random())), lineWidth: CGFloat(arc4random()%11), lineColor: UIColor.fz.randomColor(), lineDashPattern: [2, 3])

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

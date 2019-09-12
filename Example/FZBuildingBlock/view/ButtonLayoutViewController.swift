//
//  ButtonLayoutViewController.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/3/15.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ButtonLayoutViewController: UIViewController {

    let imageLeftTitleRightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 50, y: 200, width: 100, height: 50)
        button.setTitle("左图片右文字", for: .normal)
        button.setImage(UIImage.fz.image(withColor: UIColor.fz.randomColor(), size: CGSize(width: 30, height: 30)), for: .normal)
        button.fz.setImageAndTitleLayout(layoutStyle: .imageLeftAndTitleRight, spacing: 2)
        button.backgroundColor = UIColor.fz.randomColor()
        return button
    }()

    let imageTopTitleBottomButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 200, y: 200, width: 100, height: 50)
        button.setTitle("上图片下文字", for: .normal)
        button.setImage(UIImage.fz.image(withColor: UIColor.fz.randomColor(), size: CGSize(width: 30, height: 30)), for: .normal)
        button.fz.setImageAndTitleLayout(layoutStyle: .imageTopAndTitleBottom, spacing: 2)
        button.backgroundColor = UIColor.fz.randomColor()
        return button
    }()

    let imageRightTitleLeftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 50, y: 400, width: 100, height: 50)
        button.setTitle("右图片左文字", for: .normal)
        button.setImage(UIImage.fz.image(withColor: UIColor.fz.randomColor(), size: CGSize(width: 30, height: 30)), for: .normal)
        button.fz.setImageAndTitleLayout(layoutStyle: .imageRightAndTitleLeft, spacing: 2)
        button.backgroundColor = UIColor.fz.randomColor()
        return button
    }()

    let imageBottomTitleTopButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 200, y: 400, width: 100, height: 50)
        button.setTitle("下图片上文字", for: .normal)
        button.setImage(UIImage.fz.image(withColor: UIColor.fz.randomColor(), size: CGSize(width: 30, height: 30)), for: .normal)
        button.fz.setImageAndTitleLayout(layoutStyle: .imageBottomAndTitleTop, spacing: 2)
        button.backgroundColor = UIColor.fz.randomColor()
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        // Do any additional setup after loading the view.
        self.view.addSubview(self.imageLeftTitleRightButton)
        self.view.addSubview(self.imageTopTitleBottomButton)
        self.view.addSubview(self.imageRightTitleLeftButton)
        self.view.addSubview(self.imageBottomTitleTopButton)
    }

}

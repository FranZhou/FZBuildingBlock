//
//  ImageColorViewController.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/2/18.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import FZBuildingBlock
import FZWeakProxy

class ImageColorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.view.fz.onTap { (_: UITapGestureRecognizer) in
            print("UITapGestureRecognizer")
        }

        self.view.fz.onLongPress { _ in
            print("UILongPressGestureRecognizer")
        }

        self.setUpView()
    }

    func setUpView() {
        let btn = FZGradientButton(type: .custom)
        btn.fz.x = 100
        btn.fz.y = 200
        btn.fz.width = 200
        btn.fz.height = 50
        btn.setTitle("切换背景颜色", for: .normal)
        btn.addTarget(FZWeakProxy.proxy(withTarget: self), action: #selector(ImageColorViewController.btnClickAction(sender:)), for: .touchUpInside)
        btn.setVerticallyGradient(with: [UIColor.fz.randomColor(), UIColor.fz.randomColor(), UIColor.fz.randomColor()], for: .normal)
        btn.setHorizontallyGradient(with: [UIColor.fz.randomColor(), UIColor.fz.randomColor(), UIColor.fz.randomColor()], for: .highlighted)

        self.view.addSubview(btn)
    }

    @objc func btnClickAction(sender: Any) {
        let randomColor = UIColor.fz.randomColor(alpha: 1)
        guard let image = UIImage.fz.image(withColor: randomColor, size: self.view.fz.size) else {
            return
        }
        self.view.backgroundColor = UIColor(patternImage: image)

        print(randomColor.fz.rgbHexString())
        print(randomColor.fz.rgbHex())
        print(randomColor.fz.disassembleColor())
        print(String(format: "%d -> %X", randomColor.fz.rgbHex().rgbHex, randomColor.fz.rgbHex().rgbHex))

        print(image.fz.colorRGBA(atPoint: CGPoint(x: 50, y: 50))?.fz.rgbHexString() ?? "")

        self.navigationItem.fz.hideIndicator()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self.view) else {
            return
        }

        self.navigationItem.fz.showIndicator(position: .left)

        print(self.view.fz.colorRGBA(atPoint: point)?.fz.rgbHexString() ?? "")
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

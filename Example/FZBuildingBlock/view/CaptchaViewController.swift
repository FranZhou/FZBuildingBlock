//
//  CaptchaViewController.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2020/8/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import FZBuildingBlock

class CaptchaViewController: UIViewController {

    lazy var captchaView: FZCaptchaView = {
        let captchaView = FZCaptchaView(frame: CGRect(x: 50, y: 200, width: 100, height: 50))
        return captchaView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white

        captchaView.captchaString = "zF322"
        self.view.addSubview(captchaView)

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: view)
            if captchaView.frame.contains(point) {
                captchaView.refreshCaptcha()
            }
        }
    }

    deinit {
        print("CaptchaViewController deinit")
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

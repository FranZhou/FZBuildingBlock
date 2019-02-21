//
//  ImageColorViewController.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/2/18.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ImageColorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setUpView()
    }
    
    
    func setUpView() {
        let btn = UIButton(type: .custom)
        btn.fz_x = 100
        btn.fz_y = 200
        btn.fz_width = 200
        btn.fz_height = 50
        btn.setTitle("切换背景颜色", for: .normal)
        btn.addTarget(self, action: #selector(ImageColorViewController.btnClickAction(sender:)), for: .touchUpInside)
        
        self.view.addSubview(btn)
    }
    
    
    @objc func btnClickAction(sender: Any){
        guard let image = UIImage.fz_image(withColor: .fz_randomColor(), size: self.view.fz_size) else {
            return
        }
        self.view.backgroundColor = UIColor(patternImage: image)
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

//
//  StringImageViewController.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/2/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class StringImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        // Do any additional setup after loading the view.
        
        if let stringImage = UIImage.fz_image(withString: "zhoufan") {
            let imageView = UIImageView(image: stringImage)
            imageView.fz_x = 100
            imageView.fz_y = 100
            self.view.addSubview(imageView)
        }
        
        if let stringImage2 = UIImage.fz_image(withString: "FranZhouFranZhouFranZhou FranZhou FranZhou FranZhou FranZhou FranZhou FranZhou", size: CGSize(width: 100, height: 50)) {
            let imageView = UIImageView(image: stringImage2)
            imageView.fz_x = 100
            imageView.fz_y = 200
            self.view.addSubview(imageView)
        }
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

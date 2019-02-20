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
        
        if let stringImage = UIImage.fz_image(with: "zhoufan") {
            let imageView = UIImageView(image: stringImage)
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

//
//  ImageRotationViewController.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/2/18.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ImageRotationViewController: UIViewController {
    
    var image: UIImage!
    var imageView: UIImageView?
    
    var rotation: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let image = UIImage.fz_image(with: .fz_randomColor(), size: CGSize(width: 300, height: 200)) {
            self.image = image
        }else{
            self.image = UIImage()
        }
        
        self.setUpView()
    }
    
    func setUpView() {
        let btn = UIButton(type: .custom)
        btn.fz_x = 100
        btn.fz_y = 200
        btn.fz_width = 200
        btn.fz_height = 50
        btn.setTitle("旋转当前图片", for: .normal)
        btn.addTarget(self, action: #selector(ImageColorViewController.btnClickAction(sender:)), for: .touchUpInside)
        
        self.view.addSubview(btn)
        
        let imageView = UIImageView()
        imageView.image = self.image
        imageView.fz_size = self.image.size
        imageView.fz_outerCenter = self.view.fz_innerCenter
        self.view.addSubview(imageView)
        self.imageView = imageView
    }
    
    
    @objc func btnClickAction(sender: Any){
        guard let image = self.image.fz_rotate(with: rotation) else {
            return
        }
        rotation += 30
        
        imageView?.image = image
        imageView?.fz_size = image.size
        imageView?.fz_outerCenter = self.view.fz_innerCenter
        
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

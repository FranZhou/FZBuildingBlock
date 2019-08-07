//
//  ImageRotationViewController.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/2/18.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ImageRotationViewController: UIViewController {
    
    let originSize = CGSize(width: 250, height: 200)
    
    var image: UIImage!
    var imageView: UIImageView!
    var cutImageView: UIImageView!
    
    var rotation: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let image = UIImage.fz_image(withColor: .fz_randomColor(), size: CGSize(width: 250, height: 200)) {
            self.image = image
        }else{
            self.image = UIImage()
        }
        
        self.setUpView()
    }
    
    func setUpView() {
        let btn = UIButton(type: .custom)
        btn.fz_x = 100
        btn.fz_y = 100
        btn.fz_width = 200
        btn.fz_height = 50
        btn.fz_touchAreaEdge = UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
        btn.setTitle("旋转当前图片", for: .normal)
        btn.addTarget(self, action: #selector(ImageColorViewController.btnClickAction(sender:)), for: .touchUpInside)
        
        btn.addTarget(self, action: #selector(forAllEvents(sender:)), for: .allEvents)
        
        btn.fz_addAction(block: { (button) in
            print("fz_addAction touchUpInside")
            btn.fz_showIndicator()
        })

        btn.fz_addAction(block: { (button) in
            print("fz_addAction touchUpInside repeat")
        })

        btn.fz_addAction(block: { (button) in
            print("touchUpOutside")
//            button.fz_removeAction(forEvent: .touchUpInside)
            btn.fz_hideIndicator()
        }, for: .touchUpOutside)
        
        btn.fz_addAction(block: { (button) in
            print("allEvents1")
        }, for: .allEvents)
        
        self.view.addSubview(btn)
        
        self.imageView = UIImageView()
        self.view.addSubview(imageView)
        
        self.cutImageView = UIImageView()
        self.view.addSubview(cutImageView)
        
        self.changeImageToShow(withImage: self.image)
    }
    
    
    @objc func btnClickAction(sender: Any){
        guard let image = self.image.fz_rotate(withRotation: rotation) else {
            return
        }
        rotation += 30
        
        self.changeImageToShow(withImage: image)
        
    }
    
    @objc func forAllEvents(sender: Any){
        print("allEvents2")
    }
    
    func changeImageToShow(withImage image: UIImage){
        imageView!.image = image
        imageView!.fz_size = image.size
        imageView!.fz_outerCenterX = self.view.fz_outerCenterX
        imageView!.fz_outerCenterY = self.view.fz_innerCenterY - 50
        
        let originSize = CGSize(width: 250, height: 200)
        guard let cutImage = image.fz_cut(withRect: CGRect(origin: CGPoint(x: (image.size.width - originSize.width) / 2.0, y: (image.size.height - originSize.height) / 2.0), size: originSize)) else {
            return
        }
        
        cutImageView!.image = cutImage
        cutImageView!.fz_size = cutImage.size
        cutImageView!.fz_outerCenterX = self.view.fz_outerCenterX
        cutImageView!.fz_y = view.fz_height - cutImageView.fz_height - 50
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

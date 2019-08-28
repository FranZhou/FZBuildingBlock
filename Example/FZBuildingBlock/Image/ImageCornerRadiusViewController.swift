//
//  ImageCornerRadiusViewController.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/2/21.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ImageCornerRadiusViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white

        guard let image = UIImage.fz.image(withColor: .gray, size: CGSize(width: 200, height: 200)) else {
            return
        }
        
        if let cornerRadiusImage = image.fz.cornerRadius(withRadius: 100){
            let imageView = UIImageView(image: cornerRadiusImage)
            imageView.fz.x = 100
            imageView.fz.y = 100
            self.view.addSubview(imageView)
        }
        
        if let customCornerRadiusImage = image.fz.cornerRadius(leftTop: 50, leftBottom: 0, rightBottom: 100, rightTop: 30){
            let imageView = UIImageView(image: customCornerRadiusImage)
            imageView.fz.x = 100
            imageView.fz.y = 350
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

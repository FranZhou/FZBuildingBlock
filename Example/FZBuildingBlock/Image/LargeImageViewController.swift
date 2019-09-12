//
//  LargeImageViewController.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/8/21.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import FZBuildingBlock

class LargeImageViewController: UIViewController {

    lazy var largeImageView: FZLargeImageView = {
        let view = FZLargeImageView()
        view.frame = self.view.bounds
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.view.addSubview(self.largeImageView)

        if let path = Bundle.main.path(forResource: "largeImage", ofType: "jpg"),
            let image = UIImage(contentsOfFile: path) {
            self.largeImageView.setImage(image, tileSize: CGSize(width: image.size.width / 20.0, height: image.size.height / 20.0))
        }

    }

}

//
//  GIFImageViewController.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/8/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class GIFImageViewController: UIViewController {
    
    lazy var gifImageView: UIImageView = {
        let iv = UIImageView()
        if let gifFilePath = Bundle.main.path(forResource: "test_gif", ofType: "gif"){
            iv.fz_loadGIF(withFilePath: gifFilePath)
        }
        iv.sizeToFit()
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.gifImageView)
        self.gifImageView.fz_outerCenter = self.view.fz_innerCenter
        
        self.gifImageView.startAnimating()
    }
    
    deinit {
        self.gifImageView.stopAnimating()
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

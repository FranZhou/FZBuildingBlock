//
//  KeyboardObserverViewController.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/2/22.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import FZBuildingBlock

class KeyboardObserverViewController: UIViewController {
    
    let keyboardObserver = KeyboardObserver()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        keyboardObserver.keyboardStatushandle = { keyboardInfo in
            print("\(keyboardInfo)")
        }
        
        self.setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardObserver.startKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardObserver.stopKeyboardObserver()
    }
    
    
    func setUpView() {
        let textField = UITextField()
        textField.placeholder = "请输入"
        textField.frame = CGRect(x: 50, y: 100, width: 200, height: 50)
        
        self.view.addSubview(textField)
    }
    
    deinit {
        keyboardObserver.stopKeyboardObserver()
    }

}

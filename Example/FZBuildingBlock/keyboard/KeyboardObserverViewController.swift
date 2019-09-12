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
        let textField = FZTextField()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.fz.randomColor().cgColor
        textField.delegate = self
        textField.maxInputLength = 10
        textField.edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textField.placeholder = "请输入"
        textField.frame = CGRect(x: 50, y: 100, width: 200, height: 50)
        
        self.view.addSubview(textField)
        
        
        let textView = FZTextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.fz.randomColor().cgColor
        textView.frame = CGRect(x: 50, y: 300, width: 250, height: 100)
        textView.delegate = self
        textView.maxInputLength = 20
        textView.placeholderText = "请输入"
        self.view.addSubview(textView)
    }
    
    deinit {
        keyboardObserver.stopKeyboardObserver()
    }

}


extension KeyboardObserverViewController: UITextViewDelegate{
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("\(text)")
        
        return true
    }
    
}

extension KeyboardObserverViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("\(string)")
        
        return true
    }
    
}

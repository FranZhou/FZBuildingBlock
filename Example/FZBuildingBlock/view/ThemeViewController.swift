//
//  ThemeViewController.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2020/9/8.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import FZBuildingBlock

class ThemeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        FZThemeManager.manager.themeLoader { (style) -> (Bool, FZThemeMachineProtocol?)? in
            print("\(style.themeName)")
            return (false, nil)
        }
        
        self.view.fz_theme.appearance { (view, style, themeMachine) in
            switch style{
            case .light:
                view.backgroundColor = UIColor.white
            case .dark:
                view.backgroundColor = UIColor.red
            case .custom(let _):
                view.backgroundColor = UIColor.green
            }
        }
        
        setupUI()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    deinit {
        print("ThemeViewController deinit")
    }
    
}

extension ThemeViewController {
    
    func setupUI(){
        
        do{
            let btn = FZButton(frame: CGRect(x: 20, y: 100, width: 100, height: 50))
            btn.setTitle("light", for: UIControl.State.normal)
            btn.fz_theme.appearance { (btn, style, themeMachine) in
                btn.setTitleColor(UIColor.fz.randomColor(), for: UIControl.State.normal)
                btn.backgroundColor = UIColor.fz.randomColor()
            }
            
            btn.fz.addHandler(closure: { (control) in
                FZThemeManager.manager.switchCurrentTheme(to: .light)
            }, for: UIControl.Event.touchUpInside)
            self.view.addSubview(btn)
        }
        
        do{
            let btn = FZButton(frame: CGRect(x: 140, y: 100, width: 100, height: 50))
            btn.setTitle("dark", for: UIControl.State.normal)
            btn.fz_theme.appearance { (btn, style, themeMachine) in
                btn.setTitleColor(UIColor.fz.randomColor(), for: UIControl.State.normal)
                btn.backgroundColor = UIColor.fz.randomColor()
            }
            
            btn.fz.addHandler(closure: { (control) in
                FZThemeManager.manager.switchCurrentTheme(to: .dark)
            }, for: UIControl.Event.touchUpInside)
            self.view.addSubview(btn)
        }
        
        do{
            let btn = FZButton(frame: CGRect(x: 260, y: 100, width: 100, height: 50))
            btn.setTitle("custom", for: UIControl.State.normal)
            btn.fz_theme.appearance { (btn, style, themeMachine) in
                btn.setTitleColor(UIColor.fz.randomColor(), for: UIControl.State.normal)
                btn.backgroundColor = UIColor.fz.randomColor()
            }
            
            btn.fz.addHandler(closure: { (control) in
                FZThemeManager.manager.switchCurrentTheme(to: .custom("test"))
            }, for: UIControl.Event.touchUpInside)
            self.view.addSubview(btn)
        }
        
    }
    
}

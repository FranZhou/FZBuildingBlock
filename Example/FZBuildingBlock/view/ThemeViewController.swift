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
        FZThemeManager.manager.isFlowSystemThemeStyle = true
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
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if FZThemeManager.manager.currentThemeStyle == .light {
            FZThemeManager.manager.switchCurrentTheme(to: .dark)
        } else {
            FZThemeManager.manager.switchCurrentTheme(to: .light)
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
    
    deinit {
        print("ThemeViewController deinit")
    }
    
}

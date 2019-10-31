//
//  AppDelegate.swift
//  FZBuildingBlock
//
//  Created by zhoufan123 on 02/20/2019.
//  Copyright (c) 2019 zhoufan123. All rights reserved.
//

import UIKit
import FZBuildingBlock

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        print(IFAddressTool.getIFAddresses())

        print(IFAddressTool.getIFAddresses(ifaName: "en0"))

        print("ZhouFan".fz.base64Encode() ?? "")
        print("ZhouFan".fz.base64Encode()?.fz.base64Decode() ?? "")

        print("\(UIDevice.fz.totalDiskSpaceBytes())")

        if let filePath = Bundle.main.path(forResource: "FZRouterDemo", ofType: "plist") {
            FZRouter.defaultRouter.loadRouter(withFilePath: filePath)
        }

//        do {
//            let res = try FZRouter.defaultRouter.router(withRouterURL: "fran://www.franzhou.com/routerTest/router_action", extraParameters: ["name": "FranZhou"])
//            print(String(describing: res))
//        } catch FZRouterError.unableToPerform(let target, let selector) {
//            print("\(target) can't perform to \(selector)")
//        } catch FZRouterError.unknownRouterURL(let routerURL){
//            print("unknownRouterURL: \(routerURL)")
//        } catch let error{
//            print(error.localizedDescription)
//        }

        let res1 = try? FZRouter.defaultRouter.router(withRouterURL: "fran://www.franzhou.com/routerTest/router_action", extraParameters: ["name": "FranZhou"])
        print(String(describing: res1))

        let res2 = try? FZRouter.defaultRouter.router(withRouterURL: "fran://www.franzhou.com/routerTest/oc_router_action", extraParameters: ["name": "FranZhou", "age": 28])
        print(String(describing: res2))

        FZLocation.shared.requestLocationPermision(for: .locationWhenInUse) { (status) in
            print(status)
        }

        FZLocation.shared.requestLocationPermision(for: .locationWhenInUse) { (status) in
            print(status)
        }

        FZLocation.shared.requestLocationPermision(for: .locationAlways) { (status) in
            print(status)
        }
        
        FZContacts.shared.requestContactsPermission(for: .contacts) { (status) in
            print(status)
        }
        
        FZAddressBook.shared.requestAddressBookPermission { (status) in
            print(status)
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

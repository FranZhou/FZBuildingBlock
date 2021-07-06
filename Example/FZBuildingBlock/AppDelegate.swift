//
//  AppDelegate.swift
//  FZBuildingBlock
//
//  Created by zhoufan123 on 02/20/2019.
//  Copyright (c) 2019 zhoufan123. All rights reserved.
//

import UIKit
import FZBuildingBlock
import FZRouterSwift

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

        FZRouter.defaultRouter.appendRouter(withRouterURL: "fran://www.franzhou.com/routerDemo/urlRouter")

        let res3 = try? FZRouter.defaultRouter.router(withRouterURL: "fran://www.franzhou.com/routerDemo/urlRouter", extraParameters: ["name": "FranZhou", "age": 29])
        print(String(describing: res3?.returnValue))

        FZPermissionLocation.shared.requestLocationPermision(for: .whenInUse) { (status) in
            print(status)
        }

        FZPermissionLocation.shared.requestLocationPermision(for: .always) { (status) in
            print(status)
        }

        FZPermissionContacts.shared.requestContactsPermission(for: .contacts) { (status) in
            print(status)
        }

        FZPermissionAddressBook.shared.requestAddressBookPermission { (status) in
            print(status)
        }

        if #available(iOS 12.0, *) {
            FZPermissionNotification.shared.requestNotificationPermision(for: [.badge, .sound, .alert, .provisional]) { (status) in
                print(status)
            }
        } else {
            FZPermissionNotification.shared.requestNotificationPermision(for: [.badge, .sound, .alert]) { (status) in
                print(status)
            }
        }

        FZPermissionMicrophone.shared.requestMicrophonePermission { (status) in
            print(status)
        }

        FZPermissionCamera.shared.requestCameraPermission { (status) in
            print(status)
        }

        FZPermissionPhotoLibrary.shared.requestPhotoLibraryPermission { (status) in
            print(status)
        }

        FZPermissionEvent.shared.requestEventPermision(for: .event) { (status) in
            print(status)
        }

        FZPermissionEvent.shared.requestEventPermision(for: .reminder) { (status) in
            print(status)
        }

        FZPermissionBluetooth.shared.requestBluetoothPermission { (status) in
            print(status)
        }

        print(UIDevice.current.fz.getModelName())

        let date = Date.init()
        print(date)
        let addDate = date.fz.dateByAdding(years: -1, months: 0, days: 0, hours: 0, minutes: 0, seconds: 0)
        print(addDate)
        let signDate = Date.fz.date(years: 1991, months: 3, days: 22, hours: 9, minutes: 2, seconds: 22)
        print(signDate?.fz.string(with: "yyyy-MM-dd HH:mm:ss"))

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

# FZRouterSwift


[![CI Status](https://img.shields.io/travis/FranZhou/FZRouterSwift.svg?style=flat)](https://travis-ci.org/FranZhou/FZRouterSwift)
[![Version](https://img.shields.io/cocoapods/v/FZRouterSwift.svg?style=flat)](https://cocoapods.org/pods/FZRouterSwift)
[![License](https://img.shields.io/cocoapods/l/FZRouterSwift.svg?style=flat)](https://cocoapods.org/pods/FZRouterSwift)
[![Platform](https://img.shields.io/cocoapods/p/FZRouterSwift.svg?style=flat)](https://cocoapods.org/pods/FZRouterSwift)


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

FZRouterSwift is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FZRouterSwift'
```

## Directions for use

default plist file data template:
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>fran</key>
    <dict>
        <key>www.franzhou.com</key>
        <dict>
            <key>routerTest</key>
            <array>
                <dict>
                    <key>target</key>
                    <string>RouterDemo</string>
                    <key>actions</key>
                    <dict>
                        <key>router_action</key>
                        <string>testRouterAction</string>
                    </dict>
                </dict>
                <dict>
                    <key>actions</key>
                    <dict>
                        <key>oc_router_action</key>
                        <string>testOCRouterAction</string>
                        <key>oc_router_action_2</key>
                        <string>testOCRouterAction2</string>
                    </dict>
                    <key>target</key>
                    <string>OCRouterDemo</string>
                </dict>
            </array>
        </dict>
    </dict>
</dict>
</plist>
```

FZDefaultURLRouterPlistLoader will analytic transformation 
```
fran://www.franzhou.com/routerTest/router_action -> target: Target_RouterDemo action: testRouterAction:

fran://www.franzhou.com/routerTest/oc_router_action -> target: Target_OCRouterDemo action: testOCRouterAction:

fran://www.franzhou.com/routerTest/oc_router_action_2 -> target: Target_OCRouterDemo action: testOCRouterAction2:
```

out target file like this  
swift:
```
@objc(Target_RouterDemo)
class Target_RouterDemo: NSObject {

    @objc class func testRouterAction(_ dataPacket: FZRouterDataPacketProtocol) {
        if let params = dataPacket.parameters {
            print("testRouterAction parameters : \(params.description)")
        }
        dataPacket.returnValue = "Target_RouterDemo.testRouterAction"
    }
    
    @objc class func urlRouter(_ dataPacket: FZRouterDataPacketProtocol) {
        if let params = dataPacket.parameters {
            print("urlRouter parameters : \(params.description)")
        }
        dataPacket.returnValue = "Target_RouterDemo.urlRouter"
    }
}
```

oc:
```
#import <FZRouter/FZRouter-Swift.h>

@implementation Target_OCRouterDemo

+ (void)testOCRouterAction:(id<FZRouterDataPacketProtocol>)dataPacket{
    NSLog(@"testOCRouterAction parameters : %@", dataPacket.parameters);
    dataPacket.returnValue = @"Target_OCRouterDemo.testOCRouterAction";
}

+ (void)testOCRouterAction2:(id<FZRouterDataPacketProtocol>)dataPacket{
    NSLog(@"%@", dataPacket.parameters);
    dataPacket.returnValue = @(9527);
}

@end
```

we can call router like this, parameters will passing to Target-Action method. you can record return value and receive it.
```
if let result = try? FZRouter.defaultRouter.router(withRouterURL: "fran://www.franzhou.com/routerTest/router_action?name=zhoufan"){
    print("\(String(describing: result.parameters)) -> \(String(describing: result.returnValue))")
}

FZRouter.defaultRouter.router(withRouterURL: "fran://www.franzhou.com/routerTest/oc_router_action", extraParameters: ["name": "FranZhou", "age": 29])

FZRouter.defaultRouter.router(withRouterURL: "fran://www.franzhou.com/routerTest/oc_router_action_2")
```

we can update or save router in other ways:
```
FZRouter.defaultRouter.updateOrSave(withRouterURL: "fran://www.franzhou.com/routerDemo/urlRouter") { (dataPacket) in
    dataPacket.returnValue = { () -> Void in
        print("I am happy")
    }
}
if let result = try? FZRouter.defaultRouter.router(withRouterURL: "fran://www.franzhou.com/routerDemo/urlRouter"){
    print("\(String(describing: result.parameters)) -> \(String(describing: result.returnValue))")
    if let returnValue = result.returnValue as? () -> Void{
        returnValue()
    }
}
```

You can consult FZDefaultURLRouter to implement your own routing parser.


## Author

FranZhou, fairytale_zf@outlook.com<br/>
swift QQ交流群: 628172981

## License

FZRouterSwift is available under the MIT license. See the LICENSE file for more info.

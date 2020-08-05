//
//  Target_OCRouterDemo.m
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/9/5.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

#import "Target_OCRouterDemo.h"
#import <FZRouterSwift/FZRouterSwift-Swift.h>

@implementation Target_OCRouterDemo

+ (void)testOCRouterAction:(id<FZRouterDataPacketProtocol>)dataPacket{
    
    NSLog(@"%@", dataPacket.parameters);
    
    dataPacket.returnValue = @"Target_OCRouterDemo";
}

@end

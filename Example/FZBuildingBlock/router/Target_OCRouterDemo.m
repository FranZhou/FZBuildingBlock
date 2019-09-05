//
//  Target_OCRouterDemo.m
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/9/5.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

#import "Target_OCRouterDemo.h"
#import <FZBuildingBlock/FZBuildingBlock-Swift.h>

@implementation Target_OCRouterDemo

+ (void)testOCRouterAction:(FZRouterDataPacket *)dataPacket{
    
    NSLog(@"%@", dataPacket.parameters);
    
    dataPacket.targetActionReturnValue = @"Target_OCRouterDemo";
}

@end

//
//  FZProxy.h
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/11/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/// swift无法继承NSProxy，这里只能用oc来实现
@interface FZProxy : NSProxy

- (instancetype)initWithTarget:(id) target;

+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END

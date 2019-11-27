//
//  FZProxy.m
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/11/26.
//

#import "FZProxy.h"

@interface FZProxy ()

@property (nonatomic, weak) id target;

@end

@implementation FZProxy

- (instancetype)initWithTarget:(id) target{
    self.target = target;
    return self;
}

+ (instancetype)proxyWithTarget:(id)target {
    return [[self alloc] initWithTarget:target];
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    SEL sel = [invocation selector];
    if ([self.target respondsToSelector:sel]) {
        [invocation invokeWithTarget:self.target];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    return [self.target methodSignatureForSelector:sel];
}

@end

//
//  NSArray+Any.m
//  Layman
//
//  Created by James Womack on 5/19/13.
//  Copyright (c) 2013 Noble Gesture. All rights reserved.
//

#import "NSArray+Any.h"
#import <objc/runtime.h>

@interface NSArray (AnyPrivate)
- (BOOL)booleanResultOfSelector:(SEL)selector;
@end

@implementation NGAnyProxy

- (void)forwardInvocation:(NSInvocation *)invocation
{
    BOOL result = [self.array booleanResultOfSelector:invocation.selector];
    [invocation setReturnValue:&result];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *signature = nil;
    for (NSObject *obj in self.array)
    {
        if ((signature = [obj methodSignatureForSelector:selector]))
        {
            break;
        }
    }
    return signature;
}

@end

@implementation NSArray (Any)

@dynamic any;

static char NGArrayAnyKey;

- (NGAnyProxy *)any
{
    NGAnyProxy *any = nil;
    if (!objc_getAssociatedObject(self, &NGArrayAnyKey))
    {
        any = NGAnyProxy.alloc;
        any.array = self;
        objc_setAssociatedObject(self, &NGArrayAnyKey, any, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return any;
}

@end

@implementation NSArray (AnyPrivate)

- (BOOL)booleanResultOfSelector:(SEL)selector
{
    __block BOOL any = NO;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        *stop = (BOOL)[obj performSelector:selector];
        if (*stop)
        {
            any = *stop;
        }
#pragma clang diagnostic pop
    }];
    return any;
}

@end

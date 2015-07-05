//
//  NSNull+App.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "NSNull+App.h"

/**
 *  向一个实例发送一个消息后，系统是处理的流程：
 *  1. 发送消息如：[self startwork]
 *  2. 系统会check是否能response这个消息
 *  3. 如果能response则调用相应方法，不能则抛出异常
 *
 *  在第二步中，系统是如何check实例是否能response消息呢？
 *  如果实例本身就有相应的respondsToSelector,那么就会相应之，
 *  如果没有系统就会发出methodSignatureForSelector消息，寻问它这个消息是否有效？
 *  有效就返回对应的方法地址之类的，无效则返回nil。
 *  如果是nil就会crash， 如果不是nil接着发送forwardInvocation消息
 *
 *  http://www.cocoachina.com/applenews/devnews/2014/0424/8225.html
 *  https://github.com/yaakaito/Overline/tree/master/Overline/Over/NSNull
 */
@implementation NSNull (App)

//方法1

/*
 - (void)forwardInvocation:(NSInvocation *)anInvocation
 {
 SEL aSelector = [anInvocation selector];
 
 for (NSObject *obj in NSNullObjects) {
 if ([obj respondsToSelector:aSelector]) {
 [anInvocation invokeWithTarget:obj];
 return;
 }
 }
 [self doesNotRecognizeSelector:aSelector];
 }
 
 - (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
 {
 NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
 if (!signature) {
 for (NSObject *obj in NSNullObjects) {
 signature = [obj methodSignatureForSelector:aSelector];
 if (signature) {
 break;
 }
 }
 }
 return signature;
 }
 */

//方法2

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([self respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:self];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *sig = [[NSNull class] instanceMethodSignatureForSelector:aSelector];
    if (nil == sig) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
    }
    return sig;
}

@end

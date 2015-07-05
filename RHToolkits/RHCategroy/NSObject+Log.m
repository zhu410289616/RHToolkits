//
//  NSObject+Log.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "NSObject+Log.h"
#import <objc/runtime.h>

@implementation NSObject (Log)

- (NSString *)autoDescription:(Class)classType
{
    NSMutableString *propertyMutableStr = [[NSMutableString alloc] init];
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(classType, &count);
    if (NULL != properties) {
        for (int i=0; i<count; i++) {
            objc_property_t property = properties[i];
            const char *cPropertyName = property_getName(property);
            NSString *propertyName = [NSString stringWithCString:cPropertyName encoding:NSUTF8StringEncoding];
            if (propertyName) {
                @try {
                    id value = [self valueForKey:propertyName];
                    [propertyMutableStr appendFormat:@"%@: %@, ", propertyName, value];
                }
                @catch (NSException *exception) {
                    [propertyMutableStr appendFormat:@"Can't get value for property %@ through KVO", propertyName];
                }
            }//
        }//for
        free(properties);
    }//if
    
    NSString *tempDescription = nil;
    if (propertyMutableStr.length > 2) {
        tempDescription = [propertyMutableStr substringToIndex:propertyMutableStr.length - 2];
    }
    return tempDescription;
}

- (void)log:(Class)classType mark:(NSString *)mark
{
#ifdef RHLogDebug
    NSString *tempDescription = nil;
    
    // Now see if we need to map any superclasses as well.
    Class superClass = class_getSuperclass(classType);
    NSString *className = NSStringFromClass(superClass);
    if (superClass && [superClass isSubclassOfClass:[NSObject class]] && ![className isEqualToString:@"NSObject"]) {
        //
        tempDescription = [self autoDescription:superClass];
        tempDescription = [NSString stringWithFormat:@"%@, %@", tempDescription, [self autoDescription:classType]];
    } else {
        tempDescription = [self autoDescription:classType];
    }
    
    RHLogLog(@"[LOG] - (ClassName:%s)(mark:%@): %@", class_getName(classType), mark, tempDescription);
#endif
}

- (void)logWithMark:(NSString *)mark
{
    [self log:[self class] mark:mark];
}

- (void)log
{
    [self log:[self class] mark:@""];
}

@end

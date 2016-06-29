//
//  NTLockViewUsedTime.m
//  NTManagement
//
//  Created by 郑祯 on 16/6/29.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import "NTLockViewUsedTime.h"

@implementation NTLockViewUsedTime

static id lockViewUsedTime;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (lockViewUsedTime == nil) {
        @synchronized (self) {
            if (lockViewUsedTime == nil) {
                lockViewUsedTime = [super allocWithZone:zone];
            }
        }
    }
    return lockViewUsedTime;
}

+ (instancetype)sharedLockViewUsedTime {
    if (lockViewUsedTime == nil) {
        @synchronized (self) {
            if (lockViewUsedTime == nil) {
                lockViewUsedTime = [[self alloc]init];
            }
        }
    }
    return lockViewUsedTime;
}

- (id)copyWithZone:(NSZone *)zone {
    return lockViewUsedTime;
}

@end

//
//  NTLockViewSingleton.m
//  NTManagement
//
//  Created by 郑祯 on 16/6/29.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import "NTLockViewSingleton.h"

@implementation NTLockViewSingleton

static id lockViewSingleton;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (lockViewSingleton == nil) {
        @synchronized (self) {
            if (lockViewSingleton == nil) {
                lockViewSingleton = [super allocWithZone:zone];
            }
        }
    }
    return lockViewSingleton;
}

+ (instancetype)sharedLockViewSingleton {
    if (lockViewSingleton == nil) {
        @synchronized (self) {
            if (lockViewSingleton == nil) {
                lockViewSingleton = [[self alloc]init];
            }
        }
    }
    return lockViewSingleton;
}

- (id)copyWithZone:(NSZone *)zone {
    return lockViewSingleton;
}

@end

//
//  NTLockViewUsedTime.h
//  NTManagement
//
//  Created by 郑祯 on 16/6/29.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTLockViewUsedTime : NSObject

@property (nonatomic, assign) int usedTimes;

+ (instancetype)sharedLockViewUsedTime;

@end

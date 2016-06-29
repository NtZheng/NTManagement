//
//  NTLockViewSingleton.h
//  NTManagement
//
//  Created by 郑祯 on 16/6/29.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTLockViewSingleton : NSObject

// 单例中的属性
@property (nonatomic, assign) BOOL isSecondDraw;
@property (nonatomic, strong) NSMutableArray *lockIndexMutableArray;

+ (instancetype)sharedLockViewSingleton;

@end

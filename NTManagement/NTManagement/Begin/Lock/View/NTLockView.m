//
//  NTLockView.m
//  NTManagement
//
//  Created by 郑祯 on 16/6/28.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import "NTLockView.h"



@implementation NTLockView

static const int columnAndRow = 3;// 使用const变量而不是宏定义
static const int widthAndHeight = 50;

- (void)awakeFromNib {
    [self setUpAllItems];
}

#pragma mark - methods
- (void)setUpAllItems {
    for (int i = 0; i < columnAndRow*columnAndRow; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button setBackgroundImage:[UIImage imageNamed:@"phoneNumber"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateSelected];
        [self addSubview:button];
    }
    [self setUpItemFrame];
}

- (void)setUpItemFrame {
    int currentColum = 0;
    int currentRow = 0;
    int margin = (self.frame.size.width - columnAndRow*widthAndHeight) / (columnAndRow+1);
    for (int i = 0; i < columnAndRow*columnAndRow; i++) {
        currentRow = i/columnAndRow;
        currentColum = i%columnAndRow;
        self.subviews[i].frame = CGRectMake(margin + (margin+widthAndHeight)*currentColum, margin + (margin+widthAndHeight)*currentRow, widthAndHeight, widthAndHeight);
    }
}

@end

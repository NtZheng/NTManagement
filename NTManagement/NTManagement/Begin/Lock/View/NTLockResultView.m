//
//  NTLockResultView.m
//  NTManagement
//
//  Created by 郑祯 on 16/6/29.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import "NTLockResultView.h"

@implementation NTLockResultView

// 将这两个对于锁定UI定制的属性抽出来，实现封装（不关心内部怎么实现，通过这两个属性即可改变UI布局）
static const int columnAndRow = 3;// 使用const变量而不是宏定义
static const int widthAndHeight = 15;

- (void)awakeFromNib {
    [self setUpAllItems];
    self.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
}

#pragma mark - 设置按钮的方法
- (void)setUpAllItems {
    for (int i = 0; i < columnAndRow*columnAndRow; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.userInteractionEnabled = NO;// 避免button的点击效果影响到绘制图像
        [button setImage:[UIImage imageNamed:@"normalLockButton_small"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"selectedLockButton_small"] forState:UIControlStateSelected];
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


#pragma mark - API
- (void)showResultLockView :(NSMutableArray *)indexMutableArray {
    UIButton *tempButton;
    for (NSNumber *tempNumber in indexMutableArray) {
        tempButton = (UIButton *)self.subviews[[tempNumber intValue]];
        tempButton.selected = YES;
    }
}



@end

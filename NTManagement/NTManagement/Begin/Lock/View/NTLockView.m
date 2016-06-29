//
//  NTLockView.m
//  NTManagement
//
//  Created by 郑祯 on 16/6/28.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import "NTLockView.h"
#import "NTLockViewUsedTime.h"

@interface NTLockView ()

@property(nonatomic, strong) NSMutableArray *selectedItems;
@property (nonatomic, assign) CGPoint currentPoint;

@end

@implementation NTLockView

// 将这两个对于锁定UI定制的属性抽出来，实现封装（不关心内部怎么实现，通过这两个属性即可改变UI布局）
static const int columnAndRow = 3;// 使用const变量而不是宏定义
static const int widthAndHeight = 80;

- (void)awakeFromNib {
    [self setUpAllItems];
    self.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
}
#pragma mark - 懒加载
- (NSMutableArray *)selectedItems {
    if (_selectedItems == nil) {
        _selectedItems = [[NSMutableArray alloc]init];
    }
    return _selectedItems;
}

#pragma mark - methods
#pragma mark - 设置按钮的方法
- (void)setUpAllItems {
    for (int i = 0; i < columnAndRow*columnAndRow; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.userInteractionEnabled = NO;// 避免button的点击效果影响到绘制图像
        [button setImage:[UIImage imageNamed:@"normalLockButton"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"selectedLockButton"] forState:UIControlStateSelected];
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

#pragma mark - 绘制的方法
// 该方法是进行解锁手势中的画线操作
- (void)drawRect:(CGRect)rect {
    if (self.selectedItems.count) {
        // 给选中点添加路径（每次刷新便会进行一次绘制路径）
        UIBezierPath *path = [UIBezierPath bezierPath];
        for (int i = 0; i < self.selectedItems.count; i++) {
            UIButton *tempButton = self.selectedItems[i];
            if (i == 0) {
                [path moveToPoint:tempButton.center];// 如果是第一个，那么就以他为起点
            } else {
                [path addLineToPoint:tempButton.center];// 如果不是第一个，那么就添加一条线到这个点
            }
        }
        
        // 实时绘制
        [path addLineToPoint:self.currentPoint];
        
        // 设置绘制路径的样式
        [path setLineWidth:3];// 宽度
        [[UIColor colorWithRed:87/255.0 green:169/255.0 blue:223/255.0 alpha:1.0] set];// 颜色
        [path setLineJoinStyle:kCGLineJoinMiter];// 样式
        [path stroke];
    }
}

#pragma mark - 监控屏幕的触控的方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint currentPoint = [self getCurrentPoint:touches];
    UIButton *tempButton = [self buttonContainsPoint:currentPoint];
    if (tempButton && tempButton.selected == NO) {
        tempButton.selected = YES;
        [self.selectedItems addObject:tempButton];
    }
//    [self setNeedsDisplay];// 点击开始不应该绘制，不然会出现绘制问题
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint currentPoint = [self getCurrentPoint:touches];
    self.currentPoint = currentPoint;// 需要将这个值传入到全局的currentPoint中，目的是在drawRect实时绘制
    UIButton *tempButton = [self buttonContainsPoint:currentPoint];
    if (tempButton && tempButton.selected == NO) {
        tempButton.selected = YES;
        [self.selectedItems addObject:tempButton];
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSMutableArray *indexMutableArray = [NSMutableArray array];
    for (UIButton *tempButton in self.selectedItems) {
        [indexMutableArray addObject:@(tempButton.tag)];
        tempButton.selected = NO;
    }
    [self.selectedItems removeAllObjects];
    [self setNeedsDisplay];
    if ([NTLockViewUsedTime sharedLockViewUsedTime].usedTimes < 2) {
        self.finishDrawPath(indexMutableArray);// 回调block
    }
}

#pragma mark - 功能性的抽取方法
- (CGPoint)getCurrentPoint :(NSSet *)touches {
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}

- (UIButton *)buttonContainsPoint :(CGPoint)point {
    for (UIButton *tempButton in self.subviews) {
        if (CGRectContainsPoint(tempButton.frame, point)) {
            return tempButton;
        }
    }
    return nil;// 如果没有的话就返回nil
}


@end

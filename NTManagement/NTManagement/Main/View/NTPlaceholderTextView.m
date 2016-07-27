//
//  NTPlaceholderTextView.m
//  NTManagement
//
//  Created by Nineteen on 7/27/16.
//  Copyright © 2016 nineteen. All rights reserved.
//

#import "NTPlaceholderTextView.h"

@implementation NTPlaceholderTextView

// xib加载
- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textWillBeginEdit) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textEndEdit) name:UITextViewTextDidEndEditingNotification object:self];
}

// 手动创建
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //监听文本的输入
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
    }
    return self;
}
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];
}
-(void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsDisplay];
}
-(void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    //如果文本框有值就返回
    if (self.hasText) return;
    CGFloat X = 5;
    CGFloat Y = 8;
    CGFloat W = rect.size.width - 2 * X;
    CGFloat H = rect.size.width - 2 * Y;
    NSMutableDictionary *attrt = [NSMutableDictionary dictionary];
    attrt[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    attrt[NSFontAttributeName] = self.font?self.font:[UIFont systemFontOfSize:17.0];
    [self.placeholder drawInRect:CGRectMake(X, Y,W,H) withAttributes:attrt];
}
//移除通知，预防野指针
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - methods
- (void)textDidChange{
    //重绘
    [self setNeedsDisplay];
}

- (void)textWillBeginEdit {
    self.layer.borderWidth = 1;
    self.layer.borderColor = NTColor.CGColor;
}

- (void)textEndEdit {
    self.layer.borderWidth = 0;
}

@end

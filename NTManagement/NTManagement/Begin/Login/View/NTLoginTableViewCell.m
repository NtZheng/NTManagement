//
//  NTLoginTableViewCell.m
//  NTManagement
//
//  Created by 郑祯 on 16/6/27.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import "NTLoginTableViewCell.h"

@implementation NTLoginTableViewCell

// 当cell是从storyboard加载的时候将会调用此方法(默认生成，苹果推荐使用storyboard)
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;// 取消选中效果
}

@end
